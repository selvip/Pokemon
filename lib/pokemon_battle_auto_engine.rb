class PokemonBattleAutoEngine
	def initialize(pokemon_battle: )
			@pokemon_battle = pokemon_battle
			@pokemon1 = @pokemon_battle.pokemon1
			@pokemon2 = @pokemon_battle.pokemon2
	end

	def start_auto_battle?
		result = []
		result << validate_state?
		result << validate_battle_type?
		result << validate_health_point?

		result.all?
	end
	
	def begin_auto_battle
		if start_auto_battle?
			flag = true
			begin
				start_pokemon_battle_engine
				flag = false if !start_auto_battle?
			end while flag
		else
			@pokemon_battle.errors.add(:state, "Cannot battle at this point.")
		end
	end

	private
	def start_pokemon_battle_engine
		if @pokemon_battle.current_turn.even?
			attacker = @pokemon2.id
		elsif @pokemon_battle.current_turn.odd?
			attacker = @pokemon1.id
		end

		pokemon_attacker = Pokemon.find(attacker)
		pickable_skills = pokemon_attacker.pokemon_skills.where("current_pp > ?", 0)
		total_skills = pickable_skills.count

		pick_number = rand(0..total_skills-1)
		skill = pokemon_attacker.pokemon_skills[pick_number] unless pick_number == nil

		if skill.nil?
			pokemon_battle_engine = PokemonBattleEngine.new(
				pokemon_battle: @pokemon_battle,
				attacker_id: pokemon_attacker.id)
		else	
			pokemon_battle_engine = PokemonBattleEngine.new(
				pokemon_battle: @pokemon_battle,
				attacker_id: pokemon_attacker.id,
				skill_id: skill.id)
		end

		if pokemon_battle_engine.list_attack_validations?
			pokemon_battle_engine.attack
			pokemon_battle_engine.save_attack
		elsif pokemon_battle_engine.list_surrender_validations?
			pokemon_battle_engine.surrender
			pokemon_battle_engine.save_surrender
		end
	end

	def validate_battle_type?
		if @pokemon_battle.battle_type == "AutoMatch!"
			true
		else
			false
		end
	end

	def validate_state?
		if @pokemon_battle.state == "Ongoing"
			flag = true
		else
			@pokemon_battle.errors.add(:state, "Cannot act at this state.")
			flag = false		
		end
	end

	def validate_health_point?
		result = []
		result << validate_pokemon1_hp
		result << validate_pokemon2_hp

		result.all?
	end

	def validate_pokemon1_hp
		if @pokemon1.current_health_point > 0
			true
		else
			false
		end
	end

	def validate_pokemon2_hp
		if @pokemon2.current_health_point > 0
			true
		else
			false
		end
	end

end