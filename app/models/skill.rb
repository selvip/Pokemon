class Skill < ApplicationRecord
	validates :name, presence: true, length: {maximum: 45}, uniqueness: true
	validates :power, numericality: {only_integer: true, greater_than: 0}
	validates :max_pp, numericality: {only_integer: true, greater_than: 0} 
	validates :element_type, presence: true, length: {maximum: 45}
end
