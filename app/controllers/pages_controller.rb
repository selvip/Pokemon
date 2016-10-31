class PagesController < ApplicationController
	def home
		@element = []
		Skill::ELEMENT.each do |element|
			pokemon_award = PokemonAward.new(element_type: element)
			h={}
			h[:element] = element
			h[:pokemon_winners_details] = pokemon_award.most_wins
			h[:pokemon_losers_details] = pokemon_award.most_loss
			h[:surrenders] = pokemon_award.most_surrenders
			h[:skills] = pokemon_award.popular_skills
			@element << h
		end
	end
end