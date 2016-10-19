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
		set_pokemon_battle_attr
		if @pokemon_battle.valid?
			@pokemon_battle.save
			redirect_to @pokemon_battle
		else
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
		@pokemon1 = Pokemon.find(@pokemon_battle.pokemon1_id)
		@pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)
	end

	private
	def pokemon_battle_params
		params.require(:pokemon_battle).permit(
									 :pokemon1_id, 
									 :pokemon2_id
									 )
	end
	def set_pokemon_battle_attr
		@pokemon_battle.current_turn = 0
		@pokemon_battle.state = "Before"
		@pokemon_battle.pokemon_winner_id = 0
		@pokemon_battle.pokemon_loser_id = 0
		@pokemon_battle.experience_gain = 0
		@pokemon_battle.pokemon1_max_health_point = 0
		@pokemon_battle.pokemon2_max_health_point = 0
	end

end