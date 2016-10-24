class PokemonBattleEngine

	BattlePair = Struct.new(:pokemon1, :pokemon2)

	def self.surrender(pokemon_battle, coward_pokemon)
		pair = get_each_pokemon(pokemon_battle)
		if pokemon_battle.state == "Finished"
			pokemon_battle.errors.add(:state, "Already finished.")
		else
			if pokemon_battle.current_turn.odd?
				if coward_pokemon.id == pair.pokemon2
					pokemon_battle.errors.add(:state, "Cannot surrender at this state.")
				else
					defender = pair.pokemon1
					attacker = pair.pokemon2
					self.finishing_game(attacker: attacker, defender: defender, pokemon_battle: pokemon_battle)
				end
			else
				if coward_pokemon.id == pair.pokemon1 or pokemon_battle.state == "Finished"
					pokemon_battle.errors.add(:state, "Cannot surrender at this state.")
				else
					defender = pair.pokemon2
					attacker = pair.pokemon1
					self.finishing_game(attacker: attacker, defender: defender, pokemon_battle: pokemon_battle)
				end
			end
		end
	end

	def self.finishing_game(attacker:, defender:, pokemon_battle:)
		pokemon_battle.state = "Finished"
		pokemon_battle.pokemon_winner_id = attacker.id
		pokemon_battle.pokemon_loser_id = defender.id
		pokemon_battle.experience_gain = PokemonBattleCalculator.calculate_experience(defender.level)
		pokemon_battle.save

		attacker.current_experience += pokemon_battle.experience_gain
		while PokemonBattleCalculator.level_up?(
				winner_level: attacker.level, 
				total_exp: attacker.current_experience
			)
			
			attacker.level += 1
			increase_status = PokemonBattleCalculator.calculate_level_up_extra_stats
			attacker.max_health_point += increase_status[:health]
			attacker.attack += increase_status[:attack]
			attacker.defence += increase_status[:defence]
			attacker.speed += increase_status[:defence]
		end
		attacker.save
		flash[:danger] = ""
	end

	def self.get_each_pokemon(pokemon_battle)
		pair = BattlePair.new
		pair.pokemon1 = Pokemon.find(pokemon_battle.pokemon1_id)
		pair.pokemon2 = Pokemon.find(pokemon_battle.pokemon2_id)
		pair
	end

end