class PokemonsController < ApplicationController

	def index
		@pokemons = Pokemon.all
		navigation_add("Pokemon Index", "#")
	end

	def new
		@pokemon = Pokemon.new
		
		list_pokedexes = Pokedex.all
		@list_names_ids = list_pokedexes.map { |poke| [poke.name, poke.id]}
		navigation_add("Pokemon Index", pokemons_path)
		navigation_add("Pokemon New", "#")
	end

	def create
		@pokemon = Pokemon.new(new_pokemon_params)
		set_pokemon_attr
		if @pokemon.valid?
			@pokemon.save
			redirect_to pokemon_path @pokemon
		else
			list_pokedexes = Pokedex.all
			@list_names_ids = list_pokedexes.map { |poke| [poke.name, poke.id]}
			render 'new'
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

		navigation_add("Pokemon Index", pokemons_path)
		navigation_add("Pokemon Show", "#")
	end

	def edit
		@pokemon = Pokemon.find(params[:id])
		@pokedex = Pokedex.find(@pokemon.pokedex_id)
		navigation_add("Pokemon Index", pokemons_path)
		navigation_add("Pokemon Show", @pokemon)
		navigation_add("Pokemon Edit", "#")
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
		@pokemon.destroy
		redirect_to pokemons_path
	end

	def heal
		@pokemon = Pokemon.find(params[:pokemon_id])
		flag = true
		
		@pokemon.pokemon_battles.each do |pokemon_battle|
			flag = false if pokemon_battle.state == "Ongoing"
		end

		if flag
			@pokemon.current_health_point = @pokemon.max_health_point
			@pokemon.pokemon_skills.each do |pokemon_skill| 
				pokemon_skill.current_pp = pokemon_skill.skill_max_pp
				pokemon_skill.save
			end
			@pokemon.save
			redirect_to @pokemon
		else
			flash[:danger] = "Cannot heal"
			@pokemons = Pokemon.all
			render 'index'
		end
	end

	def heal_all
		@pokemons = Pokemon.all
		cant_be_healed = []
		@pokemons.each do |pokemon|
			flag = true
			result = pokemon.pokemon_battles.where(state: 'Ongoing')
			if result.blank?
				pokemon.current_health_point = pokemon.max_health_point
				pokemon.pokemon_skills.each do |pokemon_skill| 
					pokemon_skill.current_pp = pokemon_skill.skill_max_pp
					pokemon_skill.save
				end
				pokemon.save
			else
				cant_be_healed << pokemon.name
			end
		end
		flash[:danger] = "#{cant_be_healed.to_sentence} can't be healed" if cant_be_healed.count > 0
		@pokemons = Pokemon.all
		render 'index'
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
