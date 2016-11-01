class PokemonShowAward
	def initialize(pokemon:)
		@pokemon = pokemon
	end

	def pokemon_stats
		number_of_battles
		number_of_loss
		number_of_wins
		most_used_skill


		@pokemon_stats = {}
		@pokemon_stats[:battles] = @number_of_battles.first["count"]
		@pokemon_stats[:wins] = @number_of_wins.first["count"]
		@pokemon_stats[:loss] = @number_of_loss.first["count"]
		@pokemon_stats[:skill] = @most_used_skill
		@pokemon_stats[:losing] = percentage_loss
		@pokemon_stats[:winning] = percentage_win
		@pokemon_stats
	end

	private

	def number_of_loss
		@number_of_loss = ActiveRecord::Base.connection.execute(
			"select count(*) from pokemons, pokemon_battles
			where pokemons.id = #{@pokemon.id}
			and pokemon_battles.pokemon_loser_id = pokemons.id").to_a
	end

	def number_of_battles
		@number_of_battles = ActiveRecord::Base.connection.execute(
			"select count(*) from pokemons, pokemon_battles 
			where pokemons.id = #{@pokemon.id}
			and (pokemons.id = pokemon_battles.pokemon1_id
			or pokemons.id = pokemon_battles.pokemon2_id)").to_a
	end

	def number_of_wins
		@number_of_wins = ActiveRecord::Base.connection.execute(
			"select count(*) from pokemons, pokemon_battles
			where pokemons.id = #{@pokemon.id}
			and pokemon_battles.pokemon_winner_id = pokemons.id").to_a
	end

	def most_used_skill
		skills = ActiveRecord::Base.connection.execute(
			"select skill_id, count(skill_id) as num_used from pokemon_battle_logs 
			where attacker_id = #{@pokemon.id} and action_type = 'Attack'
			group by skill_id
			order by num_used desc").to_a
		@most_used_skill = []
		skills.each do |skill|
			h = {}
			h[:skill] = PokemonSkill.find(skill["skill_id"])
			h[:count] = skill["num_used"]
			@most_used_skill << h
		end
	end

	def percentage_loss
		percentage_loss = @number_of_loss.first["count"] * 100.0 / @number_of_battles.first["count"]
	end

	def percentage_win
		percentage_win = @number_of_wins.first["count"] * 100.0 / @number_of_battles.first["count"]
	end

end