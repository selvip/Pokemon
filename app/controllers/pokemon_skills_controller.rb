class PokemonSkillsController < ApplicationController

	def index
		@pokemon_skills = PokemonSkill.all
	end

	def new
		@pokemon_skill = PokemonSkill.new
	end

	def create
		get_pokemon
		@pokemon_skill = PokemonSkill.new(pokemon_skill_params)
		set_pokemon_skill_attr
		@pokemon_skill.pokemon_id = @pokemon.id
		if @pokemon_skill.valid?
			@pokemon_skill.save
			redirect_to @pokemon
		else
			@pokemon_skills = @pokemon.pokemon_skills
			@pokemon_skill = PokemonSkill.new
			@pokemon_skill.pokemon_id = @pokemon.id
			list_skill = Skill.all
			@list_names_ids = list_skill.map { |sk| [sk.name, sk.id] }

			pokemon_show_award = PokemonShowAward.new(
				pokemon: @pokemon)
			@pokemon_stats = pokemon_show_award.pokemon_stats
			
			navigation_add("Pokemon Index", pokemons_path)
			navigation_add("Pokemon Show", "#")
			render 'pokemons/show'
		end
	end

	def destroy
		get_pokemon
		@pokemon_skill = PokemonSkill.find(params[:id])
		@pokemon_skill.destroy
		redirect_to @pokemon
	end

	private
	def pokemon_skill_params
		params.require(:pokemon_skill).permit(
			:skill_id
			)
	end

	def set_pokemon_skill_attr
		skill = Skill.find(@pokemon_skill.skill_id)
		@pokemon_skill.current_pp = skill.max_pp
	end

	def get_pokemon
		@pokemon = Pokemon.find(params[:pokemon_id])
	end

end