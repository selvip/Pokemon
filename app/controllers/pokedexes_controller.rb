class PokedexesController < ApplicationController

	def index
		@pokedexes = Pokedex.all
		
		@element_type = []
		Skill::ELEMENT.each do |element|
			pokedex_award = PokedexAward.new(element_type: element)
			h = {}
			h[:element] = element
			h[:best_pokedexes] = pokedex_award.level
			h[:all_pokedexes] = pokedex_award.all_normal_pokedex
			@element_type << h
		end
		
		navigation_add("Pokedex Index", "#")
	end

	def new
		@pokedex = Pokedex.new
		navigation_add("Pokedex Index", pokedexes_path)
		navigation_add("New Pokedex", "#")	
	end

	def create	
		@pokedex = Pokedex.new(pokedex_params)
		if @pokedex.valid?
			@pokedex.save
			redirect_to pokedex_path(@pokedex)
		else
			render 'new'
		end
	end

	def edit
		@pokedex = Pokedex.find(params[:id])
		navigation_add("Pokedex Index", pokedexes_path)
		navigation_add("Edit Pokedex", "#")
	end

	def update
		@pokedex = Pokedex.find(params[:id])
		if @pokedex.update_attributes(pokedex_params)
			redirect_to pokedex_path(@pokedex)
		else
			render 'edit'
		end
	end

	def show
		@pokedex = Pokedex.find(params[:id])

		navigation_add("Pokedex Index", pokedexes_path)
		navigation_add("Pokedex Show", "#")
	end

	def destroy
		@pokedex = Pokedex.find(params[:id])
		name = @pokedex.name
		@pokedex.destroy
		flash[:notice] = "#{name} removed."
		redirect_to pokedexes_path
	end

	private
	def pokedex_params
		params.require(:pokedex).permit(
			:name, 
			:base_health_point, 
			:base_attack,
			:base_defence,
			:base_speed,
			:element_type,
			:image_url
			)
	end

end
