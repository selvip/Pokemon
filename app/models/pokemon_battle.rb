class PokemonBattle < ApplicationRecord
	validates :pokemon1_id, presence: true
	validates :pokemon2_id, presence: true
	validates :current_turn, presence: true
	validates :state, presence: true
	validates :pokemon_winner_id, presence: true
	validates :pokemon_loser_id, presence: true
	validates :experience_gain, presence: true
	validates :pokemon1_max_health_point, presence: true
	validates :pokemon1_max_health_point, presence: true
end
