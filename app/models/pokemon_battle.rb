class PokemonBattle < ApplicationRecord
	belongs_to :pokemon1, class_name: 'Pokemon'
	belongs_to :pokemon2, class_name: 'Pokemon'
	validates :pokemon1_id, presence: true
	validates :pokemon2_id, presence: true
	validate :check_pokemon1_and_pokemon2
	validate :check_pokemon_hp_zero
	# validates :current_turn, presence: true
	# validates :state, presence: true
	# validates :pokemon_winner_id, presence: true
	# validates :pokemon_loser_id, presence: true
	# validates :experience_gain, presence: true
	# validates :pokemon1_max_health_point, presence: true
	# validates :pokemon2_max_health_point, presence: true

	def check_pokemon_hp_zero
		@list_pokemons = []
		Pokemon.all.each { |poke| @list_pokemons << poke if poke.current_health_point > 0 }
		unless @list_pokemons.include? pokemon1 and @list_pokemons.include? pokemon2
			errors.add(:pokemon1_id, "Cannot add Pokemon with empty HP.")
			errors.add(:pokemon2_id, "Cannot add Pokemon with empty HP.")
		end
	end

	def check_pokemon1_and_pokemon2
		if self.pokemon2_id == self.pokemon1_id
			errors.add(:pokemon1_id, "Cannot be the same pokemon.")
			errors.add(:pokemon2_id, "Cannot be the same pokemon.")
		end
	end

	def pokemon1_name
		pokemon1.name
	end

	def pokemon2_name
		pokemon2.name
	end

end
