class PokemonBattle < ApplicationRecord
	include
	#belongs_to :pokemons
	validates :pokemon1_id, presence: true
	validates :pokemon2_id, presence: true
	validate :check_pokemon1_and_pokemon2
	# validates :current_turn, presence: true
	# validates :state, presence: true
	# validates :pokemon_winner_id, presence: true
	# validates :pokemon_loser_id, presence: true
	# validates :experience_gain, presence: true
	# validates :pokemon1_max_health_point, presence: true
	# validates :pokemon2_max_health_point, presence: true

	def check_pokemon1_and_pokemon2
		if self.pokemon2_id == self.pokemon1_id
			errors.add(:pokemon1_id, "Cannot be the same pokemon.")
			errors.add(:pokemon2_id, "Cannot be the same pokemon.")
		end
	end
end
