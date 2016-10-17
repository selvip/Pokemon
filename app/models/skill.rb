class Skill < ApplicationRecord
	validates :name, presence: true, length: {maximum: 45}, uniqueness: true
<<<<<<< HEAD
	validates :power, numericality: { greater_than: 0}
	validates :max_pp, numericality: { greater_than: 0} 
=======
	validates :power, numericality: {only_integer: true, greater_than: 0}
	validates :max_pp, numericality: {only_integer: true, greater_than: 0} 
>>>>>>> ea5f79120c0a19aaf74a980859c0a6fc666967a7
	validates :element_type, presence: true, length: {maximum: 45}
end
