class PokemonBattleEngine

	def initialize(pokemon_battle_id:, attacker_id:, skill_id: nil)
		@pokemon_battle = PokemonBattle.find(pokemon_battle_id)
		@attacker = Pokemon.find(attacker_id)
		case attacker_id.to_i
		when @pokemon_battle.pokemon1_id
			@defender = Pokemon.find(@pokemon_battle.pokemon2.id)
		when @pokemon_battle.pokemon2_id
			@defender = Pokemon.find(@pokemon_battle.pokemon1.id)
		end
		@pokemon_skill = PokemonSkill.find(skill_id) if !skill_id.nil?
	end

	def try_to_attack
		list_attack_validations?
		if list_attack_validations?
			attack
		end
	end

	def try_to_surrender
		temp = @attacker
		@attacker = @defender
		@defender = temp

		list_surrender_validations?
		if list_surrender_validations?
			finishing_game
			save_all
		end
	end

	private

	def list_surrender_validations?
		invalidate_state
		invalidate_turn
		if validate_state? and validate_turn?
			flag = true
		else
			flag = false
		end
	end
	def list_attack_validations?
		\invalidate_state?
		invalidate_current_pp
		invalidate_pokemon_skill
		invalidate_turn
		if validate_state? and validate_current_pp? and validate_pokemon_skill? and validate_turn?
			flag = true
		else
			flag = false
		end
	end
	def invalidate_turn
		if !validate_turn?
			@pokemon_battle.validate_attack_odd
			@pokemon_battle.validate_attack_even
		end
	end
	def invalidate_pokemon_skill
		if !validate_pokemon_skill?
			@pokemon_battle.validate_pokemon_skill
		end
	end
	def invalidate_current_pp
		if !validate_current_pp?
			@pokemon_skill.validate_current_pp
		end
	end
	
	def validate_state?
		if @pokemon_battle.state == "Ongoing"
			flag = true
		else
			pokemon_battle.errors.add(state, "Cannot act at this state.")
			flag = false		
		end
	end
	def validate_turn?
		if @pokemon_battle.current_turn.odd?
			flag = false
			flag = true if @attacker.id == @pokemon_battle.pokemon1_id
		elsif @pokemon_battle.current_turn.even?
			flag = false
			flag = true if @attacker.id == @pokemon_battle.pokemon2_id
		end
	end
	def validate_current_pp?
		@pokemon_skill.current_pp > 0
	end
	def validate_pokemon_skill?
		@attacker.pokemon_skills.include? @pokemon_skill
	end

	def check_win
		if @defender.current_health_point <= 0
			@defender.current_health_point = 0
			finishing_game
		end
		save_all
	end

	def save_all
		ActiveRecord::Base.transaction do
			@pokemon_battle.save
			@attacker.save
			@defender.save
			@pokemon_skill.save if !@pokemon_skill.nil?
		end
	end

	def finishing_game
		@pokemon_battle.state = "Finished"
		@pokemon_battle.pokemon_winner_id = @attacker.id
		@pokemon_battle.pokemon_loser_id = @defender.id
		@pokemon_battle.experience_gain = PokemonBattleCalculator.calculate_experience(@defender.level)

		@attacker.current_experience += @pokemon_battle.experience_gain
		while PokemonBattleCalculator.level_up?(
				winner_level: @attacker.level, 
				total_exp: @attacker.current_experience
			)
			
			@attacker.level += 1
			increase_status = PokemonBattleCalculator.calculate_level_up_extra_stats
			@attacker.max_health_point += increase_status[:health]
			@attacker.attack += increase_status[:attack]
			@attacker.defence += increase_status[:defence]
			@attacker.speed += increase_status[:defence]
		end
	end

	def attack
		@pokemon_skill.current_pp -= 1
		@pokemon_battle.current_turn += 1
		
		damage = PokemonBattleCalculator.calculate_damage(
			attacker_pokemon: @attacker, 
			defender_pokemon: @defender, 
			skill_id: @pokemon_skill.skill_id)

		@defender.current_health_point -= damage
		check_win
	end
end