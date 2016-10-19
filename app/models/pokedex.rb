class Pokedex < ApplicationRecord	
	validates :name, 
		presence: true, 
		length: {maximum: 45}, 
		uniqueness: true
	validates :base_health_point, 
		presence: true, 
		numericality: {	only_integer: true, greater_than: 0}
	validates :base_attack, 
		presence: true, 
		numericality: { only_integer: true, greater_than: 0}
	validates :base_defence, 
		presence: true, 
		numericality: {	only_integer: true,	greater_than: 0}
	validates :base_speed, 
		presence: true, 
		numericality: {	only_integer: true,	greater_than: 0}
	validates :element_type, 
		presence: true, 
		length: {	maximum: 45}, 
		inclusion: {in: Skill::ELEMENT}

end
