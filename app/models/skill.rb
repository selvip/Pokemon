class Skill < ApplicationRecord

	ELEMENT = [
			'normal',
			'fight',
			'flying',
			'poison',
			'ground',
			'rock',
			'rug',
			'ghost',
			'steel',
			'fire',
			'water',
			'grass',
			'electro',
			'psychic',
			'ice',
			'dragon',
			'dark',
			'fairy'
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
