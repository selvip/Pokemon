require 'spec_helper'
require 'rails_helper'
require 'pry'

describe "Pokemon Battle Engine Validation" do 
	before(:each) do
		@pokedex_sample_1 = ::Pokedex.new
		@pokedex_sample_1.name = "Pokedess"
		@pokedex_sample_1.base_health_point = 10
		@pokedex_sample_1.base_attack = 10
		@pokedex_sample_1.base_defence = 10
		@pokedex_sample_1.base_speed = 10
		@pokedex_sample_1.element_type = "ice"
		@pokedex_sample_1.image_url = "metapod_image.png"
		@pokedex_sample_1.save

		@sample_1 = ::Pokemon.new
		@sample_1.pokedex = @pokedex_sample_1
		@sample_1.name = 'Poke'
		@sample_1.level = 10
		@sample_1.max_health_point = 10
		@sample_1.current_health_point = 10
		@sample_1.attack = 10
		@sample_1.defence = 10
		@sample_1.speed = 10
		@sample_1.current_experience = 10
		@sample_1.save

		@sample_2 = ::Pokemon.new
		@sample_2.pokedex = @pokedex_sample_1
		@sample_2.name = 'Mon'
		@sample_2.level = 10
		@sample_2.max_health_point = 10
		@sample_2.current_health_point = 10
		@sample_2.attack = 10
		@sample_2.defence = 10
		@sample_2.speed = 10
		@sample_2.current_experience = 10
		@sample_2.save

		@sample_skill_2 = ::Skill.new
		@sample_skill_2.name = "Skill 1"
		@sample_skill_2.power = 10
		@sample_skill_2.max_pp = 10
		@sample_skill_2.element_type = 'dark'
		@sample_skill_2.save

		@sample_skill_1 = ::Skill.new
		@sample_skill_1.name = "Skill 2"
		@sample_skill_1.power = 10
		@sample_skill_1.max_pp = 10
		@sample_skill_1.element_type = 'ice'
		@sample_skill_1.save

		@ps_sample_1 = ::PokemonSkill.new
		@ps_sample_1.pokemon_id = @sample_1.id
		@ps_sample_1.skill_id = @sample_skill_2.id
		@ps_sample_1.current_pp = 10
		@ps_sample_1.save

		@ps_sample_2 = ::PokemonSkill.new
		@ps_sample_2.pokemon_id = @sample_2.id
		@ps_sample_2.skill_id = @sample_skill_1.id
		@ps_sample_2.current_pp = 10
		@ps_sample_2.save

		@pokemon_battle_sample = ::PokemonBattle.new
		@pokemon_battle_sample.pokemon1_id = @sample_1.id
		@pokemon_battle_sample.pokemon2_id = @sample_2.id
		@pokemon_battle_sample.current_turn = 1
		@pokemon_battle_sample.state = "Ongoing"
		@pokemon_battle_sample.pokemon1_max_health_point = @sample_1.max_health_point
		@pokemon_battle_sample.pokemon2_max_health_point = @sample_2.max_health_point
		@pokemon_battle_sample.save
	end

	it "Sample of valid attack input" do
		pokemon_battle_engine_sample = PokemonBattleEngine.new(
			pokemon_battle: @pokemon_battle_sample,
			attacker_id: @pokemon_battle_sample.pokemon1_id,
			skill_id:  @ps_sample_1.id)
		expect(pokemon_battle_engine_sample.list_attack_validations?).to eq(true)
		pokemon_battle_engine_sample.attack
		expect(pokemon_battle_engine_sample.save_attack).to eq(true)
	end
	
	it "Sample of valid surrender input" do
		pokemon_battle_engine_sample = PokemonBattleEngine.new(
			pokemon_battle: @pokemon_battle_sample,
			attacker_id: @pokemon_battle_sample.pokemon1_id)
		expect(pokemon_battle_engine_sample.list_surrender_validations?).to eq(true)
		pokemon_battle_engine_sample.surrender
		expect(pokemon_battle_engine_sample.save_surrender).to eq(true)
	end

	describe "PokemonSkill validation" do
		it "PokemonSkill must belong to the attacker pokemon to attack" do
			pokemon_battle_engine_sample = PokemonBattleEngine.new(
				pokemon_battle: @pokemon_battle_sample,
				attacker_id: @pokemon_battle_sample.pokemon1_id,
				skill_id: @ps_sample_2.id)
			expect(pokemon_battle_engine_sample.list_attack_validations?).to eq(false)
		end

		it "PokemonSkill must exist to attack" do
			pokemon_battle_engine_sample = PokemonBattleEngine.new(
				pokemon_battle: @pokemon_battle_sample,
				attacker_id: @pokemon_battle_sample.pokemon1_id)
			expect(pokemon_battle_engine_sample.list_attack_validations?).to eq(false)
		end

		it "PokemonSkill current_pp should be greater than 0" do
			pokemon_battle_engine_sample = PokemonBattleEngine.new(
				pokemon_battle: @pokemon_battle_sample,
				attacker_id: @pokemon_battle_sample.pokemon1_id)
			expect(pokemon_battle_engine_sample.list_attack_validations?).to eq(false)
		end

		describe "PokemonSkill existance won't affect surrender method." do
			it "PokemonSkill do not exists" do
				pokemon_battle_engine_sample = PokemonBattleEngine.new(
					pokemon_battle: @pokemon_battle_sample,
					attacker_id: @pokemon_battle_sample.pokemon1_id)
				expect(pokemon_battle_engine_sample.list_surrender_validations?).to eq(true)
			end

			it "PokemonSkill exists" do
				pokemon_battle_engine_sample = PokemonBattleEngine.new(
					pokemon_battle: @pokemon_battle_sample,
					attacker_id: @pokemon_battle_sample.pokemon1_id,
					skill_id: @ps_sample_1.id)
				expect(pokemon_battle_engine_sample.list_surrender_validations?).to eq(true)
			end
		end
	end

	describe "Pokemon Battle Engine flow" do
		it "Cannot act when battle has finished" do
			@pokemon_battle_sample.state = "Finished"
			pokemon_battle_engine_sample = PokemonBattleEngine.new(
				pokemon_battle: @pokemon_battle_sample,
				attacker_id: @pokemon_battle_sample.pokemon1_id,
				skill_id: @ps_sample_1.id)	
			expect(pokemon_battle_engine_sample.list_attack_validations?).to eq(false)
			expect(pokemon_battle_engine_sample.list_surrender_validations?).to eq(false)	
		end

		it "Wrong pokemon turn to act" do
			@pokemon_battle_sample.current_turn = 2
			pokemon_battle_engine_sample = PokemonBattleEngine.new(
				pokemon_battle: @pokemon_battle_sample,
				attacker_id: @pokemon_battle_sample.pokemon1_id,
				skill_id: @ps_sample_1.id)
			expect(pokemon_battle_engine_sample.list_surrender_validations?).to eq(false)
			expect(pokemon_battle_engine_sample.list_attack_validations?).to eq(false)
		end
	end

	describe "Pokemon Battle Log" do
		it "Pokemon Battle Log should exist after attacking." do
			pokemon_battle_engine_sample = PokemonBattleEngine.new(
				pokemon_battle: @pokemon_battle_sample,
				attacker_id: @pokemon_battle_sample.pokemon1_id,
				skill_id:  @ps_sample_1.id)
			expect(pokemon_battle_engine_sample.list_attack_validations?).to eq(true)
			pokemon_battle_engine_sample.attack
			pokemon_battle_engine_sample.save_attack
			expect(PokemonBattleLog.count).to eq(1)
		end

		it "Pokemon Battle Log should exist after surrendering." do
			pokemon_battle_engine_sample = PokemonBattleEngine.new(
				pokemon_battle: @pokemon_battle_sample,
				attacker_id: @pokemon_battle_sample.pokemon1_id)
			expect(pokemon_battle_engine_sample.list_surrender_validations?).to eq(true)
			pokemon_battle_engine_sample.surrender
			pokemon_battle_engine_sample.save_surrender
			expect(PokemonBattleLog.count).to eq(1)
		end

		it "Pokemon Battle Log should be deleted once the Pokemon Battle deleted." do
			pokemon_battle_engine_sample = PokemonBattleEngine.new(
				pokemon_battle: @pokemon_battle_sample,
				attacker_id: @pokemon_battle_sample.pokemon1_id)
			expect(pokemon_battle_engine_sample.list_surrender_validations?).to eq(true)
			pokemon_battle_engine_sample.surrender
			pokemon_battle_engine_sample.save_surrender
			@pokemon_battle_sample.destroy
			expect(PokemonBattleLog.count).to eq(0)
		end

		it "Pokemon Battle Log should be deleted once the Pokemon does not exist." do
			pokemon_battle_engine_sample = PokemonBattleEngine.new(
				pokemon_battle: @pokemon_battle_sample,
				attacker_id: @pokemon_battle_sample.pokemon1_id)
			expect(pokemon_battle_engine_sample.list_surrender_validations?).to eq(true)
			pokemon_battle_engine_sample.surrender
			pokemon_battle_engine_sample.save_surrender
			@sample_2.destroy
			expect(PokemonBattle.count).to eq(0)
			expect(PokemonBattleLog.count).to eq(0)
		end
	end

end