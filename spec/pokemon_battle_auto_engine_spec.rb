require 'spec_helper'
require 'rails_helper'
require 'pry'

describe "Pokemon Battle Auto Engine Validation" do
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

		@ps_sample_3 = ::PokemonSkill.new
		@ps_sample_3.pokemon_id = @sample_2.id
		@ps_sample_3.skill_id = @sample_skill_2.id
		@ps_sample_3.current_pp = 10
		@ps_sample_3.save

		@pokemon_battle_sample = ::PokemonBattle.new
		@pokemon_battle_sample.pokemon1_id = @sample_1.id
		@pokemon_battle_sample.pokemon2_id = @sample_2.id
		@pokemon_battle_sample.current_turn = 1
		@pokemon_battle_sample.state = "Ongoing"
		@pokemon_battle_sample.battle_type = "AutoMatch!"
		@pokemon_battle_sample.pokemon1_max_health_point = @sample_1.max_health_point
		@pokemon_battle_sample.pokemon2_max_health_point = @sample_2.max_health_point
		@pokemon_battle_sample.save
	end

	it "Sample of valid Pokemon Battle Auto Input" do
		pokemon_battle_auto_sample = PokemonBattleAutoEngine.new(pokemon_battle: @pokemon_battle_sample)
		pokemon_battle_auto_sample.begin_auto_battle
		expect(@pokemon_battle_sample.pokemon_winner_id.nil?).to eq(false)
	end

	it "If autobattle is longer than 1000 loops" do
		pokemon_battle_auto_sample = PokemonBattleAutoEngine.new(pokemon_battle: @pokemon_battle_sample)
		if pokemon_battle_auto_sample.start_auto_battle?
			flag = true
			flagger = 0
			begin
				pokemon_battle_auto_sample.instance_eval{start_pokemon_battle_engine}
				flag = false if !pokemon_battle_auto_sample.start_auto_battle?
				flagger += 1
			end while flag
		else
			@pokemon_battle.errors.add(:state, "Cannot battle at this point.")
		end

		expect(@pokemon_battle_sample.pokemon_winner_id.nil?).to eq(false)
		expect(flagger).to be < 1000
	end

	it "If the two pokemon has no skill, then surrender" do
		@ps_sample_1.destroy
		@ps_sample_2.destroy
		@ps_sample_3.destroy
		pokemon_battle_auto_sample = PokemonBattleAutoEngine.new(pokemon_battle: @pokemon_battle_sample)
		pokemon_battle_auto_sample.begin_auto_battle
		expect(@pokemon_battle_sample.pokemon_winner_id.nil?).to eq(false)
		expect(PokemonBattleLog.count).to eq(1)
	end
end