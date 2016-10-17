class Skill < ApplicationRecord
	validates :name, presence: true, length: {maximum: 45}, uniqueness: true
	validates :power, numericality: { greater_than: 0}
	validates :max_pp, numericality: { greater_than: 0} 
	validates :element_type, presence: true, length: {maximum: 45}
end
