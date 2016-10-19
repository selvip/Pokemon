class PokemonSkill < ApplicationRecord
	belongs_to :pokemon
	belongs_to :skill
	validates :skill_id, presence: true
	validates :pokemon_id, presence: true
	validates_uniqueness_of :skill_id, scope: :pokemon_id
	validates :current_pp, 
		presence: true, 
		numericality: {
			only_integer: true,
			greater_than_or_equal_to: 0, 
			less_than_or_equal_to: :skill_max_pp}

	def skill_name
		skill.name
	end

	def skill_power
		skill.power
	end

	def skill_max_pp
		skill.max_pp
	end

	def skill_element_type
		skill.element_type
	end
end
