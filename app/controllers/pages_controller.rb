class PagesController < ApplicationController
	def home
		@element = []
		Skill::ELEMENT.each do |element|
			pokemon_award = PokemonAward.new(element_type: element)
			h={}
			h[:element] = element
			reverse = pokemon_award.most_wins.sort_by { |h| h[:win_percent]}
			h[:pokemon_winners_details] = reverse.reverse
			reverse = pokemon_award.most_loss.sort_by { |h| h[:loss_percent]}
			h[:pokemon_losers_details] = reverse.reverse
			h[:surrenders] = pokemon_award.most_surrenders
			h[:skills] = pokemon_award.popular_skills
			@element << h
		end
	end
end