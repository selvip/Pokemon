require 'spec_helper'
require 'rails_helper'
require 'pry'

describe "Pokemon Battle's pokemons availability" do
	
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

		@sample_3 = ::Pokemon.new
		@sample_3.pokedex = @pokedex_sample_1
		@sample_3.name = 'Mongg'
		@sample_3.level = 10
		@sample_3.max_health_point = 10
		@sample_3.current_health_point = 0
		@sample_3.attack = 10
		@sample_3.defence = 10
		@sample_3.speed = 10
		@sample_3.current_experience = 10
		@sample_3.save				
	end

	it "Sample of true input" do
		pokemon_battle_sample = ::PokemonBattle.new
		pokemon_battle_sample.pokemon1_id = @sample_1.id
		pokemon_battle_sample.pokemon2_id = @sample_2.id
		pokemon_battle_sample.current_turn = 1
		pokemon_battle_sample.state = "Ongoing"
		pokemon_battle_sample.pokemon1_max_health_point = @sample_1.max_health_point
		pokemon_battle_sample.pokemon2_max_health_point = @sample_2.max_health_point
		expect(pokemon_battle_sample.save).to eq(true)
	end

	it "Pokemon1 ID is not integer" do
		pokemon_battle_sample = ::PokemonBattle.new
		pokemon_battle_sample.pokemon1_id = "a"
		pokemon_battle_sample.pokemon2_id = @sample_2.id
		pokemon_battle_sample.current_turn = 1
		pokemon_battle_sample.state = "Ongoing"
		pokemon_battle_sample.pokemon1_max_health_point = @sample_1.max_health_point
		pokemon_battle_sample.pokemon2_max_health_point = @sample_2.max_health_point
		expect(pokemon_battle_sample.save).to eq(false)
		expect(pokemon_battle_sample.errors.include? :pokemon1_id).to eq(true)
	end

	it "Pokemon2 ID is not integer" do
		pokemon_battle_sample = ::PokemonBattle.new
		pokemon_battle_sample.pokemon1_id = @sample_1.id
		pokemon_battle_sample.pokemon2_id = ['bebek', 'sepatu']
		pokemon_battle_sample.current_turn = 1
		pokemon_battle_sample.state = "Ongoing"
		pokemon_battle_sample.pokemon1_max_health_point = @sample_1.max_health_point
		pokemon_battle_sample.pokemon2_max_health_point = @sample_2.max_health_point
		expect(pokemon_battle_sample.save).to eq(false)
		expect(pokemon_battle_sample.errors.include? :pokemon2_id).to eq(true)
	end

	it "State is neither Ongoing or Finished" do
		pokemon_battle_sample = ::PokemonBattle.new
		pokemon_battle_sample.pokemon1_id = @sample_1.id
		pokemon_battle_sample.pokemon2_id = @sample_2.id
		pokemon_battle_sample.current_turn = 1
		pokemon_battle_sample.state = "State"
		pokemon_battle_sample.pokemon1_max_health_point = @sample_1.max_health_point
		pokemon_battle_sample.pokemon2_max_health_point = @sample_2.max_health_point
		expect(pokemon_battle_sample.save).to eq(false)
		expect(pokemon_battle_sample.errors.include? :state).to eq(true)
	end

	it "Pokemon HP cannot be 0 to enter a battle." do
		pokemon_battle_sample = ::PokemonBattle.new
		pokemon_battle_sample.pokemon1_id = @sample_2.id
		pokemon_battle_sample.pokemon2_id = @sample_3.id
		pokemon_battle_sample.current_turn = 1
		pokemon_battle_sample.state = "Ongoing"
		pokemon_battle_sample.pokemon1_max_health_point = @sample_2.max_health_point
		pokemon_battle_sample.pokemon2_max_health_point = @sample_3.max_health_point
		expect(pokemon_battle_sample.save).to eq(false)
		expect(pokemon_battle_sample.errors.include? :pokemon2_id).to eq(true)
	end 

	it "Max health point should not be zero" do
		pokemon_battle_sample = ::PokemonBattle.new
		pokemon_battle_sample.pokemon1_id = @sample_1.id
		pokemon_battle_sample.pokemon2_id = @sample_2.id
		pokemon_battle_sample.current_turn = 1
		pokemon_battle_sample.state = "Ongoing"
		pokemon_battle_sample.pokemon1_max_health_point = @sample_1.max_health_point
		pokemon_battle_sample.pokemon2_max_health_point = 0
		expect(pokemon_battle_sample.save).to eq(false)
		expect(pokemon_battle_sample.errors.include? :pokemon2_max_health_point).to eq(true)
	end

	it "Pokemons going to the battle should be different." do
		pokemon_battle_sample = ::PokemonBattle.new
		pokemon_battle_sample.pokemon1_id = @sample_1.id
		pokemon_battle_sample.pokemon2_id = @sample_1.id
		pokemon_battle_sample.current_turn = 1
		pokemon_battle_sample.state = "Finished"
		pokemon_battle_sample.pokemon1_max_health_point = @sample_1.max_health_point
		pokemon_battle_sample.pokemon2_max_health_point = @sample_1.max_health_point
		expect(pokemon_battle_sample.save).to eq(false)
		expect(pokemon_battle_sample.errors.include? :pokemon1_id).to eq(true)
		expect(pokemon_battle_sample.errors.include? :pokemon2_id).to eq(true)
	end


	it "Turn should not be lower than 0" do
		pokemon_battle_sample = ::PokemonBattle.new
		pokemon_battle_sample.pokemon1_id = @sample_1.id
		pokemon_battle_sample.pokemon2_id = @sample_2.id
		pokemon_battle_sample.current_turn = -1
		pokemon_battle_sample.state = "Ongoing"
		pokemon_battle_sample.pokemon1_max_health_point = @sample_1.max_health_point
		pokemon_battle_sample.pokemon2_max_health_point = @sample_2.max_health_point
		expect(pokemon_battle_sample.save).to eq(false)
		expect(pokemon_battle_sample.errors.include? :current_turn).to eq(true)
	end

end