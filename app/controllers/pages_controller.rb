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

	private

	def the_big_three_skills
		skills_query = "select skills.id, count(skills.name) as number_of_skills 
			from pokemon_battle_logs, pokemon_skills, skills
			where pokemon_battle_logs.skill_id = pokemon_skills.id and pokemon_skills.skill_id = skills.id
			group by skills.id
			order by number_of_skills desc
			limit 3"
		most_skills = ActiveRecord::Base.connection.execute(skills_query).to_a
		
		@skills = []
		most_skills.each do |skill|
			h = {}
			h[:skill] = Skill.find(skill["id"])
			h[:times_used] = skill["number_of_skills"]
			@skills << h
		end
	end

end