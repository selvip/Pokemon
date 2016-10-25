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
		@pokemon_battle = PokemonBattle.find(params[:id])
		get_each_pokemon
	end

	def attack
		@pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])

		pokemon_battle_engine = PokemonBattleEngine.new(
			pokemon_battle: @pokemon_battle, 
			attacker_id: params[:attacker_id], 
			skill_id: params[:skill_id])
		if pokemon_battle_engine.list_attack_validations?
			pokemon_battle_engine.attack
			pokemon_battle_engine.save_attack
			redirect_to @pokemon_battle
		else
			get_each_pokemon
			render 'show'
		end
		
	end

	def surrender
		@pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
		pokemon_battle_engine = PokemonBattleEngine.new(
			pokemon_battle: @pokemon_battle,
			attacker_id: params[:surrender_id])
		if pokemon_battle_engine.list_surrender_validations?
			pokemon_battle_engine.try_to_surrender
			pokemon_battle_engine.save_surrender
			redirect_to @pokemon_battle
		else
			get_each_pokemon
			render 'show'	
		end
	end

	private
	
	def pokemon_battle_params
		params.require(:pokemon_battle).permit(
									 :pokemon1_id, 
									 :pokemon2_id
									 )
	end

	def set_pokemon_battle_attr
		@pokemon_battle.current_turn = 1
		@pokemon_battle.state = "Ongoing"
		@pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
		@pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point
	end

	def get_each_pokemon
		@pokemon1 = Pokemon.find(@pokemon_battle.pokemon1_id)
		@pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)
	end

end