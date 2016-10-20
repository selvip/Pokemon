class PokemonBattlesController < ApplicationController
	def index
		@pokemon_battles = PokemonBattle.all
	end

	def new
		@pokemon_battle = PokemonBattle.new
		@list_pokemons = Pokemon.all.map { |poke| [poke.name, poke.id] }
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
		attacker = Pokemon.find(params[:attacker_id])
		skill = PokemonSkill.find(params[:skill_id])
		if @pokemon_battle.current_turn.odd?
			if @attacker == @pokemon1
				@defender = @pokemon2
				skill.current_pp -= 1
				skill.save
				@pokemon_battle.current_turn += 1
				@pokemon_battle.save
				flash[:danger] = ""
				check_win
			else
				flash[:danger] = "Pokemon 1 turn."
			end
		else
			if attacker == @pokemon2
				defender = pokemon1
				skill.current_pp -= 1
				skill.save
				@pokemon_battle.current_turn += 1
				@pokemon_battle.save
				flash[:danger] = ""
				check_win
			else
				flash[:danger] = "Pokemon 2 turn."
			end
		end
		render 'show'
	end

	private
	def check_win
		if @defender.current_health_point <= 0
			@defender.current_health_point = 0
			@pokemon_battle.state = "Finished"
			@pokemon_battle.pokemon_winner_id = attacker.id
			@pokemon_battle.pokemon_loser_id = defender.id
			@pokemon_battle.save
		end
	end
	def pokemon_battle_params
		params.require(:pokemon_battle).permit(
									 :pokemon1_id, 
									 :pokemon2_id
									 )
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