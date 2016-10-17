class Pokedex < ApplicationRecord
	validates :name, presence: true, length: {maximum: 45}, uniqueness: true
	validates :base_health_point, presence: true
	validates :base_attack, presence: true
	validates :base_defence, presence: true
	validates :base_speed, presence: true
	validates :element_type, presence: true, length: {maximum: 45} 
	validates :image_url, presence: true
end
