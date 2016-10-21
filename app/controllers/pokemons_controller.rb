class PokemonsController < ApplicationController

	def index
		@pokemons = Pokemon.all
	end

	def new
		@pokemon = Pokemon.new
		list_pokedexes = Pokedex.all
		@list_names_ids = list_pokedexes.map { |poke| [poke.name, poke.id]}
	end

	def create
		@pokemon = Pokemon.new(new_pokemon_params)
		set_pokemon_attr
		if @pokemon.valid?
			@pokemon.save
			redirect_to pokemon_path @pokemon
		else
			redirect_to new_pokemon_path, :flash => {:danger => 'Name already taken.'}
		end
	end

	def show
		@pokemon = Pokemon.find(params[:id])
		@pokedex = Pokedex.find(@pokemon.pokedex_id)

		@pokemon_skills = @pokemon.pokemon_skills
		@pokemon_skill = PokemonSkill.new
		@pokemon_skill.pokemon_id = @pokemon.id
		list_skill = Skill.all
		@list_names_ids = list_skill.map { |sk| [sk.name, sk.id] }
	end

	def edit
		@pokemon = Pokemon.find(params[:id])
		@pokedex = Pokedex.find(@pokemon.pokedex_id)
	end

	def update
		@pokemon = Pokemon.find(params[:id])
		if @pokemon.update_attributes(edit_pokemon_params)
			redirect_to @pokemon
		else
			@pokedex = Pokedex.find(@pokemon.pokedex_id)
			render 'edit'
		end
	end

	def destroy
		@pokemon = Pokemon.find(params[:id])
		list_pokemon_battles = PokemonBattle.all.select { |battle| battle if battle.pokemon1_id == @pokemon.id or battle.pokemon2_id == @pokemon.id}
		list_pokemon_battles.each { |battle| battle.destroy }
		@pokemon.destroy
		redirect_to pokemons_path
	end

	private
	def new_pokemon_params
		params.require(:pokemon).permit(
			:pokedex_id,
			:name
			)
	end

	def edit_pokemon_params
		params.require(:pokemon).permit(
			:pokedex_id,
			:name,
			:level,
			:max_health_point,
			:current_health_point,
			:attack,
			:defence,
			:speed,
			:current_experience
			)
	end

	def set_pokemon_attr
		pokedex = Pokedex.find(@pokemon.pokedex_id)
		@pokemon.level = 1
		@pokemon.max_health_point = pokedex.base_health_point
		@pokemon.current_health_point = pokedex.base_health_point
		@pokemon.attack = pokedex.base_attack
		@pokemon.defence = pokedex.base_defence
		@pokemon.speed = pokedex.base_speed
		@pokemon.current_experience = 0
	end

end
