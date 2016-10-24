class PokemonBattleCalculator
	IncreaseStatus = Struct.new(:health, :attack, :defence, :speed)
	ATTACK_DEFEND = {
		:normal => {
			:normal => 1,
			:fight => 1,
			:flying => 1,
			:poison => 1,
			:ground => 1,
			:rock => 0.5,
			:bug => 1,
			:ghost => 0,
			:steel => 0.5,
			:fire => 1,
			:water => 1,
			:grass => 1,
			:electro => 1,
			:psychic => 1,
			:ice => 1,
			:dragon => 1,
			:dark => 1,
			:fairy => 1
		},
		:fight => {
			:normal => 2,
			:fight => 1,
			:flying => 0.5,
			:poison => 0.5,
			:ground => 1,
			:rock => 2,
			:bug => 0.5,
			:ghost => 0,
			:steel => 2,
			:fire => 1,
			:water => 1,
			:grass => 1,
			:electro => 1,
			:psychic => 0.5,
			:ice => 2,
			:dragon => 1,
			:dark => 2,
			:fairy => 0.5
		},
		:flying => {
			:normal => 1,
			:fight => 2,
			:flying => 1,
			:poison => 1,
			:ground => 1,
			:rock => 0.5,
			:bug => 2,
			:ghost => 1,
			:steel => 0.5,
			:fire => 1,
			:water => 1,
			:grass => 2,
			:electro => 0.5,
			:psychic => 1,
			:ice => 1,
			:dragon => 1,
			:dark => 1,
			:fairy => 1
		},
		:poison => {
			:normal => 1,
			:fight => 1,
			:flying => 1,
			:poison => 0.5,
			:ground => 0.5,
			:rock => 0.5,
			:bug => 1,
			:ghost => 0.5,
			:steel => 0,
			:fire => 1,
			:water => 1,
			:grass => 2,
			:electro => 1,
			:psychic => 1,
			:ice => 1,
			:dragon => 1,
			:dark => 1,
			:fairy => 2
		},
		:ground => {
			:normal => 1,
			:fight => 1,
			:flying => 0,
			:poison => 2,
			:ground => 1,
			:rock => 2,
			:bug => 0.5,
			:ghost => 1,
			:steel => 2,
			:fire => 2,
			:water => 1,
			:grass => 0.5,
			:electro => 2,
			:psychic => 1,
			:ice => 1,
			:dragon => 1,
			:dark => 1,
			:fairy => 1
		},
		:rock => {
			:normal => 1,
			:fight => 0.5,
			:flying => 2,
			:poison => 1,
			:ground => 0.5,
			:rock => 1,
			:bug => 2,
			:ghost => 1,
			:steel => 0.5,
			:fire => 2,
			:water => 1,
			:grass => 1,
			:electro => 1,
			:psychic => 1,
			:ice => 2,
			:dragon => 1,
			:dark => 1,
			:fairy => 1
		},
		:bug => {
			:normal => 1,
			:fight => 0.5,
			:flying => 0.5,
			:poison => 0.5,
			:ground => 1,
			:rock => 1,
			:bug => 1,
			:ghost => 0.5,
			:steel => 0.5,
			:fire => 0.5,
			:water => 1,
			:grass => 2,
			:electro => 1,
			:psychic => 2,
			:ice => 1,
			:dragon => 1,
			:dark => 2,
			:fairy => 0.5
		},
		:ghost => {
			:normal => 0,
			:fight => 1,
			:flying => 1,
			:poison => 1,
			:ground => 1,
			:rock => 1,
			:bug => 1,
			:ghost => 2,
			:steel => 1,
			:fire => 1,
			:water => 1,
			:grass => 1,
			:electro => 1,
			:psychic => 2,
			:ice => 1,
			:dragon => 1,
			:dark => 0.5,
			:fairy => 1
		},
		:steel => {
			:normal => 1,
			:fight => 1,
			:flying => 1,
			:poison => 1,
			:ground => 1,
			:rock => 2,
			:bug => 1,
			:ghost => 1,
			:steel => 0.5,
			:fire => 0.5,
			:water => 0.5,
			:grass => 1,
			:electro => 0.5,
			:psychic => 1,
			:ice => 2,
			:dragon => 1,
			:dark => 1,
			:fairy => 2
		},
		:fire => {
			:normal => 1,
			:fight => 1,
			:flying => 1,
			:poison => 1,
			:ground => 1,
			:rock => 0.5,
			:bug => 2,
			:ghost => 1,
			:steel => 2,
			:fire => 0.5,
			:water => 0.5,
			:grass => 2,
			:electro => 1,
			:psychic => 1,
			:ice => 2,
			:dragon => 0.5,
			:dark => 1,
			:fairy => 1
		},
		:water => {
			:normal => 1,
			:fight => 1,
			:flying => 1,
			:poison => 1,
			:ground => 2,
			:rock => 2,
			:bug => 1,
			:ghost => 1,
			:steel => 1,
			:fire => 2,
			:water => 0.5,
			:grass => 0.5,
			:electro => 1,
			:psychic => 1,
			:ice => 1,
			:dragon => 0.5,
			:dark => 1,
			:fairy => 1
		},
		:grass => {
			:normal => 1,
			:fight => 1,
			:flying => 0.5,
			:poison => 0.5,
			:ground => 2,
			:rock => 2,
			:bug => 0.5,
			:ghost => 1,
			:steel => 0.5,
			:fire => 0.5,
			:water => 2,
			:grass => 0.5,
			:electro => 1,
			:psychic => 1,
			:ice => 1,
			:dragon => 0.5,
			:dark => 1,
			:fairy => 1
		},
		:electro => {
			:normal => 1,
			:fight => 1,
			:flying => 2,
			:poison => 1,
			:ground => 0,
			:rock => 1,
			:bug => 1,
			:ghost => 1,
			:steel => 1,
			:fire => 1,
			:water => 2,
			:grass => 0.5,
			:electro => 0.5,
			:psychic => 1,
			:ice => 1,
			:dragon => 0.5,
			:dark => 1,
			:fairy => 1
		},
		:psychic => {
			:normal => 1,
			:fight => 2,
			:flying => 1,
			:poison => 2,
			:ground => 1,
			:rock => 1,
			:bug => 1,
			:ghost => 1,
			:steel => 0.5,
			:fire => 1,
			:water => 1,
			:grass => 1,
			:electro => 1,
			:psychic => 0.5,
			:ice => 1,
			:dragon => 1,
			:dark => 0,
			:fairy => 1
		},
		:ice => {
			:normal => 1,
			:fight => 1,
			:flying => 2,
			:poison => 1,
			:ground => 2,
			:rock => 1,
			:bug => 1,
			:ghost => 1,
			:steel => 0.5,
			:fire => 0.5,
			:water => 0.5,
			:grass => 2,
			:electro => 1,
			:psychic => 1,
			:ice => 0.5,
			:dragon => 2,
			:dark => 1,
			:fairy => 1
		},
		:dragon => {
			:normal => 1,
			:fight => 1,
			:flying => 1,
			:poison => 1,
			:ground => 1,
			:rock => 1,
			:bug => 1,
			:ghost => 1,
			:steel => 0.5,
			:fire => 1,
			:water => 1,
			:grass => 1,
			:electro => 1,
			:psychic => 1,
			:ice => 1,
			:dragon => 2,
			:dark => 1,
			:fairy => 0
		},
		:dark => {
			:normal => 1,
			:fight => 0.5,
			:flying => 1,
			:poison => 1,
			:ground => 1,
			:rock => 1,
			:bug => 1,
			:ghost => 2,
			:steel => 1,
			:fire => 1,
			:water => 1,
			:grass => 1,
			:electro => 1,
			:psychic => 2,
			:ice => 1,
			:dragon => 1,
			:dark => 0.5,
			:fairy => 0.5
		},
		:fairy => {
			:normal => 1,
			:fight => 2,
			:flying => 1,
			:poison => 0.5,
			:ground => 1,
			:rock => 1,
			:bug => 1,
			:ghost => 1,
			:steel => 0.5,
			:fire => 0.5,
			:water => 1,
			:grass => 1,
			:electro => 1,
			:psychic => 1,
			:ice => 1,
			:dragon => 2,
			:dark => 2,
			:fairy => 1
		}
	}

	def self.calculate_damage(attacker_pokemon:, defender_pokemon:, skill_id:)
		sk = Skill.find(skill_id)
		random_number = rand(85..100)
		
		stab =  if attacker_pokemon.skills == defender_pokemon.skills
			1.5
		else
			1
		end

		attacker_pokedex = attacker_pokemon.pokedex
		defender_pokedex = defender_pokemon.pokedex
		weak_rest = ATTACK_DEFEND[attacker_pokedex.element_type.to_sym][defender_pokedex.element_type.to_sym]

		damage = ((((2.00 * attacker_pokemon.level / 5 + 2) * attacker_pokemon.attack * sk.power / defender_pokemon.defence ) / 50) + 2) * stab * weak_rest * ( random_number / 100.0)
		damage = damage.ceil
	end

	def self.calculate_experience(enemy_level)
		random_number = rand(20..150)
		experience_gain = random_number * enemy_level
	end

	def self.level_up?(winner_level:, total_exp:)
		exp_needed = 2 ** winner_level  * 100
		if total_exp >= exp_needed
			level_up = true
		else
			level_up = false
		end
	end

	def self.calculate_level_up_extra_stats		
		inc_status = IncreaseStatus.new
		inc_status.health = rand(10..20)
		inc_status.attack = rand(1..5)
		inc_status.defence = rand(1..5)
		inc_status.speed = rand(1..5)
		inc_status
	end

end
