class SkillAward
	def initialize(element_type:)
		@element_type = element_type
	end

	def most_used_skill
		query_for_skill = ActiveRecord::Base.connection.execute(
			"select skills.id, skills.name, count(skills.id) as number_of_skills 
			from pokemon_battle_logs, pokemon_skills, skills
			where pokemon_battle_logs.skill_id = pokemon_skills.id and pokemon_skills.skill_id = skills.id and skills.element_type = '#{@element_type}'
			group by skills.id, skills,name
			order by number_of_skills desc").to_a
		@best_skills = []
		query_for_skill.each do |skill|
			h = {}
			h[:skill] = Skill.find(skill["id"])
			h[:count] = skill["number_of_skills"]
			@best_skills << h
		end
		@best_skills
	end

	def all_normal_skill
		query_for_show = ActiveRecord::Base.connection.execute(
			"select skills.id
			from skills
			where skills.element_type = '#{@element_type}'").to_a
		@all_pokedexes = []
		query_for_show.each do |skill|
			h = {}
			h[:skill] = Skill.find(skill["id"])
			@all_pokedexes << h
		end
		@all_pokedexes
	end
end