class PokemonAward
	
	def initialize(element_type:)
		@element_type = element_type
	end

	def most_wins
		winning_query = 
		"select pokemons.id, pokemons.name, count(pokemon_battles.id) as number_of_win
			from pokemon_battles, pokemons, pokedexes
			where pokemon_battles.state = 'Finished' and pokemons.pokedex_id = pokedexes.id and pokedexes.element_type = '#{@element_type}' and pokemon_battles.pokemon_winner_id = pokemons.id
			group by pokemons.name, pokemons.id
			order by number_of_win desc
			limit 3"
		pokemon_winners = ActiveRecord::Base.connection.execute(winning_query).to_a
		
		@pokemon_winners_details = []
		pokemon_winners.each do |pokemon|
			winning_rate_query = "select count (*) from pokemon_battles 
				where state = 'Finished'
				and pokemon_loser_id = #{pokemon['id']}
				or pokemon_winner_id = #{pokemon['id']}"
			winning_rate_queries = ActiveRecord::Base.connection.execute(winning_rate_query)
			h = {}
			h[:pokemon] = Pokemon.find(pokemon["id"])
			h[:winning_number] = pokemon["number_of_win"]
			h[:battle_number] = winning_rate_queries.first["count"] 
			h[:win_percent] = pokemon["number_of_win"] * 100.00 / winning_rate_queries.first["count"] 
			@pokemon_winners_details << h
		end
		@pokemon_winners_details
	end

	def most_loss
		losing_query = 
		"select pokemons.id, pokemons.name, count(pokemon_battles.id) as number_of_loss
			from pokemon_battles, pokemons, pokedexes
			where pokemon_battles.state = 'Finished' and pokemons.pokedex_id = pokedexes.id and pokedexes.element_type = '#{@element_type}' and pokemon_battles.pokemon_loser_id = pokemons.id
			group by pokemons.name, pokemons.id
			order by number_of_loss desc
			limit 3"
		pokemon_losers = ActiveRecord::Base.connection.execute(losing_query).to_a
		
		@pokemon_losers_details = []
		pokemon_losers.each do |pokemon|
			losing_rate_query = "select count (*) from pokemon_battles 
				where state = 'Finished'
				and pokemon_loser_id = #{pokemon['id']}
				or pokemon_winner_id = #{pokemon['id']}"
			losing_rate_queries = ActiveRecord::Base.connection.execute(losing_rate_query)
			h = {}
			h[:pokemon] = Pokemon.find(pokemon["id"])
			h[:losing_number] = pokemon["number_of_loss"]
			h[:battle_number] = losing_rate_queries.first["count"] 
			h[:loss_percent] = pokemon["number_of_loss"] * 100.00 / losing_rate_queries.first["count"] 
			@pokemon_losers_details << h
		end
		@pokemon_losers_details
	end

	def most_surrenders
		surrender_query =
			"select pokemons.id, pokemons.name, count(pokemon_battle_logs.defender_id) as surrender_number
			from pokemon_battle_logs, pokemons, pokedexes
			where pokemon_battle_logs.action_type = 'Surrender' and pokemon_battle_logs.defender_id = pokemons.id and pokemons.pokedex_id = pokedexes.id and pokedexes.element_type = '#{@element_type}'
			group by pokemons.name, pokemons.id
			order by surrender_number desc
			limit 3"
		most_surrenders = ActiveRecord::Base.connection.execute(surrender_query).to_a
		@surrenders = []
		most_surrenders.each do |surrender|
			h = {}
			h[:pokemon] = Pokemon.find(surrender["id"])
			h[:surrender_times] = surrender["surrender_number"]
			@surrenders << h
		end
		@surrenders
	end

	def popular_skills
		skills_query = "select skills.id, skills.name, count(skills.id) as number_of_skills 
			from pokemon_battle_logs, pokemon_skills, skills
			where pokemon_battle_logs.skill_id = pokemon_skills.id and pokemon_skills.skill_id = skills.id and skills.element_type = '#{@element_type}'
			group by skills.id, skills,name
			order by number_of_skills desc
			limit 3"
		most_skills = ActiveRecord::Base.connection.execute(skills_query).to_a
		
		@skills = []
		most_skills.each do |skill|
			h = {}
			h[:skill] = Skill.find(skill["id"])
			h[:times_used] = skill["number_of_skills"]
			@skills << h
		end
		@skills
	end
end