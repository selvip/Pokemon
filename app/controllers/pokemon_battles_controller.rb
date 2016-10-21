class PokemonBattlesController < ApplicationController
	def index
		@pokemon_battles = PokemonBattle.all
	end

	def new
		@pokemon_battle = PokemonBattle.new
		@list_pokemons = []
		Pokemon.all.each { |poke| @list_pokemons << [poke.name, poke.id] if poke.current_health_point > 0 }
	end

	def create
		@pokemon_battle = PokemonBattle.new(pokemon_battle_params)
		get_each_pokemon
		set_pokemon_battle_attr
		if @pokemon_battle.valid?
			@pokemon_battle.save
			redirect_to @pokemon_battle
		else
			@list_pokemons = Pokemon.all.map { |poke| [poke.name, poke.id] }
			render 'new'
		end
	end

	def destroy
		@pokemon_battle = PokemonBattle.find(params[:id])
		@pokemon_battle.destroy
		redirect_to pokemon_battles_path
	end

	def show
		flash[:danger] = ""
		@pokemon_battle = PokemonBattle.find(params[:id])
		get_each_pokemon
	end

	def attack
		@pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
		get_each_pokemon
		@attacker = Pokemon.find(params[:attacker_id])
		@pokemon_skill = PokemonSkill.find(params[:skill_id])
		if @attacker.pokemon_skills.include? @pokemon_skill
			if @pokemon_battle.current_turn.odd?
				if @attacker == @pokemon1
					@defender = @pokemon2
					if 	@pokemon_skill.current_pp > 0
						try_to_attack
					else
						flash[:danger] = "Current PP is zero."
					end
				else
					flash[:danger] = "Pokemon 1 turn."
				end
			else
				if @attacker == @pokemon2
					@defender = @pokemon1
					if 	@pokemon_skill.current_pp > 0
						try_to_attack
					else
						flash[:danger] = "Current PP is zero."
					end
				else
					flash[:danger] = "Pokemon 2 turn."
				end
			end
		else
			flash[:danger] = "Unauthorized skill."
		end
		render 'show'
	end

	def surrender
		@pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
		get_each_pokemon
		surrender = Pokemon.find(params[:surrender_id])
		
		if @pokemon_battle.current_turn.odd?
			if surrender.id == @pokemon2.id or @pokemon_battle.state == "Finished"
				flash[:danger] = "Cannot surrender on this turn."
			else
				@pokemon_battle.state = "Finished"
				@pokemon_battle.pokemon_loser_id = @pokemon2.id
				@pokemon_battle.pokemon_winner_id = @pokemon1.id
				@pokemon_battle.save
				flash[:danger] = ""
			end
		else
			if surrender.id == @pokemon1.id or @pokemon_battle.state == "Finished"
				flash[:danger] = "Cannot surrender on this turn."
			else
				@pokemon_battle.state = "Finished"
				@pokemon_battle.pokemon_loser_id = @pokemon1.id
				@pokemon_battle.pokemon_winner_id = @pokemon2.id
				@pokemon_battle.save
				flash[:danger] = ""
			end
		end

		render 'show'
	end

	private

	def try_to_attack
		@pokemon_skill.current_pp -= 1
		@pokemon_skill.save
		
		@pokemon_battle.current_turn += 1
		save_pokemon_battle
		
		damage = PokemonBattleCalculator.calculate_damage(
			attacker_pokemon: @attacker, 
			defender_pokemon: @defender, 
			skill_id: @pokemon_skill.skill_id)
		@defender.current_health_point -= damage
		@defender.save

		flash[:danger] = ""	
		check_win
	end

	def save_pokemon_battle
		@pokemon_battle.save
	end

	def check_win
		if @defender.current_health_point <= 0
			@defender.current_health_point = 0
			@defender.save
			@pokemon_battle.state = "Finished"
			@pokemon_battle.pokemon_winner_id = @attacker.id
			@pokemon_battle.pokemon_loser_id = @defender.id
			save_pokemon_battle
			flash[:danger] = ""
		end
	end
	def pokemon_battle_params
		params.require(:pokemon_battle).permit(
									 :pokemon1_id, 
									 :pokemon2_id
									 )
	end

	def damaging

	end

	def set_pokemon_battle_attr
		@pokemon_battle.current_turn = 1
		@pokemon_battle.state = "Ongoing"
		@pokemon_battle.pokemon_winner_id = 0
		@pokemon_battle.pokemon_loser_id = 0
		@pokemon_battle.experience_gain = 0
		@pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
		@pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point
	end
	def get_each_pokemon
		@pokemon1 = Pokemon.find(@pokemon_battle.pokemon1_id)
		@pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)
	end

end