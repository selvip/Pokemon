class PokemonBattleEngine

	def initialize(pokemon_battle:, attacker_id:, skill_id: nil)
		@pokemon_battle = pokemon_battle
		@attacker = Pokemon.find(attacker_id)

		case attacker_id.to_i
		when @pokemon_battle.pokemon1_id
			@defender = Pokemon.find(@pokemon_battle.pokemon2.id)
		when @pokemon_battle.pokemon2_id
			@defender = Pokemon.find(@pokemon_battle.pokemon1.id)
		end
		@pokemon_skill = PokemonSkill.find(skill_id) if !skill_id.nil?
	end

	def next_turn
		@pokemon_battle.current_turn += 1
		@pokemon_battle.save
	end

	def attack
		@pokemon_skill.current_pp -= 1
		
		@damage = PokemonBattleCalculator.calculate_damage(
			attacker_pokemon: @attacker, 
			defender_pokemon: @defender, 
			skill_id: @pokemon_skill.skill_id)

		@defender.current_health_point -= @damage

		adding_log_stats("Attack")
		check_win
	end

	def surrender
		adding_log_stats("Surrender")
		finishing_game
	end

	def list_attack_validations?
		result = []
		result << validate_state?
		result << validate_current_pp?
		result << validate_pokemon_skill?
		result << validate_turn?
		result.all?
	end

	def list_surrender_validations?
		temp = @attacker
		@attacker = @defender
		@defender = temp

		result = []
		result << validate_state?
		result << validate_surrender_turn?
		result.all?
	end

	def save_surrender
		ActiveRecord::Base.transaction do
			@pokemon_battle.save
			@attacker.save
			@defender.save
			@pokemon_battle_log.save
		end
	end

	def save_attack
		ActiveRecord::Base.transaction do
			@pokemon_battle.save
			@attacker.save
			@defender.save
			@pokemon_skill.save
			@pokemon_battle_log.save
		end
	end

	private

	def validate_state?
		if @pokemon_battle.state == "Ongoing"
			flag = true
		else
			@pokemon_battle.errors.add(:state, "Cannot act at this state.")
			flag = false		
		end
	end
	
	def validate_turn?
		if @pokemon_battle.current_turn.odd?
			if @attacker.id == @pokemon_battle.pokemon1_id
				flag = true
			elsif @attacker.id ==@pokemon_battle.pokemon2_id
				@pokemon_battle.errors.add(:pokemon2_id, "Pokemon 1's turn.")
				flag = false			
			end
		elsif @pokemon_battle.current_turn.even?
			if @attacker.id == @pokemon_battle.pokemon2_id
				flag = true
			elsif @attacker.id == @pokemon_battle.pokemon1_id
				@pokemon_battle.errors.add(:pokemon1_id, "Pokemon2's turn.")
				flag = false			
			end
		end
	end

	def validate_surrender_turn?
		if @pokemon_battle.current_turn.odd?
			if @defender.id == @pokemon_battle.pokemon1_id
				flag = true
			else
				@pokemon_battle.errors.add(:pokemon2_id, "Pokemon 1's turn.")
				flag = false
			end
		elsif @pokemon_battle.current_turn.even?
			if @defender.id == @pokemon_battle.pokemon2_id
				flag = true
			elsif @attacker.id == @pokemon_battle.pokemon1_id
				@pokemon_battle.errors.add(:pokemon1_id, "Pokemon 2's turn.")
				flag = false
			end
				
		end	
	end

	def validate_current_pp?
		if @pokemon_skill.nil?
			flag = false
		else
			if @pokemon_skill.current_pp > 0
				flag = true
			else
				@pokemon_battle.errors.add(:base, "Current PP is 0")
				flag = false
			end
		end
		flag
	end
	
	def validate_pokemon_skill?
		@attacker.pokemon_skills.include? @pokemon_skill
	end

	def check_win
		if @defender.current_health_point <= 0
			@defender.current_health_point = 0
			finishing_game
		else
			next_turn
		end
	end

	def adding_log_stats(action_type)
		@pokemon_battle_log = PokemonBattleLog.new
		@pokemon_battle_log.pokemon_battle_id = @pokemon_battle.id
		@pokemon_battle_log.turn = @pokemon_battle.current_turn
		@pokemon_battle_log.damage = @damage
		@pokemon_battle_log.skill_id = @pokemon_skill.id if !@pokemon_skill.nil?
		@pokemon_battle_log.attacker_id = @attacker.id
		@pokemon_battle_log.attacker_current_health_point = @attacker.current_health_point
		@pokemon_battle_log.defender_id = @defender.id
		@pokemon_battle_log.defender_current_health_point = @defender.current_health_point
		@pokemon_battle_log.defender_current_health_point = 0 if @defender.current_health_point < 0
		@pokemon_battle_log.action_type = action_type
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

end