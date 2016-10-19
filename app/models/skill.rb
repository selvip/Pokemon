class Skill < ApplicationRecord

	ELEMENT = [
			"Normal",
			"Fire",
			"Fighting",
			"Water",
			"Flying",
			"Grass",
			"Poison",
			"Electric",
			"Ground",
			"Psychic",
			"Rock",
			"Ice",
			"Bug",
			"Dragon",
			"Ghost",
			"Dark",
			"Steel",
			"Fairy"
		]

	has_many :pokemon_skills, dependent: :destroy
	validates :name, 
		presence: true, 
		length: {maximum: 45}, 
		uniqueness: true
	validates :power, 
		numericality: {only_integer: true, greater_than: 0}
	validates :max_pp, 
		numericality: {only_integer: true, greater_than: 0} 
	validates :element_type, 
		presence: true, 
		length: {maximum: 45}, 
		inclusion: { in: ELEMENT }
end
