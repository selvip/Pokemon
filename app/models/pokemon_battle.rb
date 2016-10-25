class PokemonBattle < ApplicationRecord
	belongs_to :pokemon1, class_name: 'Pokemon'
	belongs_to :pokemon2, class_name: 'Pokemon'
	validates :pokemon1_id, presence: true
	validates :pokemon2_id, presence: true
	validate :check_pokemon1_and_pokemon2
	validate :check_pokemon_hp_zero

	def check_pokemon_hp_zero
		@list_pokemons = []
		Pokemon.all.each { |poke| @list_pokemons << poke if poke.current_health_point > 0 }
		if self.state == "Ongoing"
			if @list_pokemons.exclude? pokemon1
				errors.add(:pokemon1_id, "Cannot add Pokemon with empty HP.")
			elsif @list_pokemons.exclude? pokemon2
				errors.add(:pokemon2_id, "Cannot add Pokemon with empty HP.")
			end
		end
	end

	def pokemon1_name
		pokemon1.name
	end

	def pokemon2_name
		pokemon2.name
	end

	def pokemon1_image
		pokemon1.pokedex_image
	end

	def pokemon2_image
		pokemon2.pokedex_image
	end
end
