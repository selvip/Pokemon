require 'spec_helper'
require 'rails_helper'
require 'pry'

describe 'Pokemon validation' do
	it "Pokemon name should be unique." do
		pokedex_sample_1 = ::Pokedex.new
		pokedex_sample_1.name = "Pokedess"
		pokedex_sample_1.base_health_point = 10
		pokedex_sample_1.base_attack = 10
		pokedex_sample_1.base_defence = 10
		pokedex_sample_1.base_speed = 10
		pokedex_sample_1.element_type = "ice"
		pokedex_sample_1.image_url = "metapod_image.png"
		expect(pokedex_sample_1.save).to eq(true)

		sample_1 = Pokemon.new
		sample_1.pokedex = pokedex_sample_1
		sample_1.name = 'Poke'
		sample_1.level = 1
		sample_1.max_health_point = 10
		sample_1.current_health_point = 0
		sample_1.attack = 10
		sample_1.defence = 10
		sample_1.speed = 10
		sample_1.current_experience = 0
		sample_1.save

		sample_2 = Pokemon.new
		sample_2.pokedex = pokedex_sample_1
		sample_2.name = 'Poke'
		sample_2.level = 1
		sample_2.max_health_point = 10
		sample_2.current_health_point = 0
		sample_2.defence = 10
		sample_2.attack = 10
		sample_2.speed = 10
		sample_2.current_experience = 0
		expect(sample_2.save).to eq(false)
		expect(sample_2.errors.include?(:name)).to eq(true)
	end

	it "Pokemon's Pokedex should exist." do
		sample_1 = Pokemon.new
		sample_1.name = 'Poke'
		sample_1.level = 1
		sample_1.max_health_point = 10
		sample_1.current_health_point = 0
		sample_1.attack = 10
		sample_1.defence = 10
		sample_1.speed = 10
		sample_1.current_experience = 0
		expect(sample_1.save).to eq(false)
		expect(sample_1.errors.include?(:pokedex)).to eq(true)
	end

	it "Pokemon's current health point should not exceed max health point." do
		pokedex_sample_1 = ::Pokedex.new
		pokedex_sample_1.name = "Pokedess"
		pokedex_sample_1.base_health_point = 10
		pokedex_sample_1.base_attack = 10
		pokedex_sample_1.base_defence = 10
		pokedex_sample_1.base_speed = 10
		pokedex_sample_1.element_type = "ice"
		pokedex_sample_1.image_url = "metapod_image.png"
		expect(pokedex_sample_1.save).to eq(true)

		sample_1 = Pokemon.new
		sample_1.pokedex = pokedex_sample_1
		sample_1.name = 'Poke'
		sample_1.level = 1
		sample_1.max_health_point = 10
		sample_1.current_health_point = 20
		sample_1.attack = 10
		sample_1.defence = 10
		sample_1.speed = 10
		sample_1.current_experience = 0
		expect(sample_1.save).to eq(false)
		expect(sample_1.errors.include? :current_health_point).to eq(true)
	end

	it "Pokemon's current health point should not be lower than 0." do
		pokedex_sample_1 = ::Pokedex.new
		pokedex_sample_1.name = "Pokedess"
		pokedex_sample_1.base_health_point = 10
		pokedex_sample_1.base_attack = 10
		pokedex_sample_1.base_defence = 10
		pokedex_sample_1.base_speed = 10
		pokedex_sample_1.element_type = "ice"
		pokedex_sample_1.image_url = "metapod_image.png"
		expect(pokedex_sample_1.save).to eq(true)

		sample_1 = Pokemon.new
		sample_1.pokedex = pokedex_sample_1
		sample_1.name = 'Poke'
		sample_1.level = 1
		sample_1.max_health_point = 10
		sample_1.current_health_point = -9
		sample_1.attack = 10
		sample_1.defence = 10
		sample_1.speed = 10
		sample_1.current_experience = 0
		expect(sample_1.save).to eq(false)
		expect(sample_1.errors.include? :current_health_point).to eq(true)
	end

	it "Pokemon's exp' should not be lower than 0." do
		pokedex_sample_1 = ::Pokedex.new
		pokedex_sample_1.name = "Pokedess"
		pokedex_sample_1.base_health_point = 10
		pokedex_sample_1.base_attack = 10
		pokedex_sample_1.base_defence = 10
		pokedex_sample_1.base_speed = 10
		pokedex_sample_1.element_type = "ice"
		pokedex_sample_1.image_url = "metapod_image.png"
		expect(pokedex_sample_1.save).to eq(true)

		sample_1 = Pokemon.new
		sample_1.pokedex = pokedex_sample_1
		sample_1.name = 'Poke'
		sample_1.level = 1
		sample_1.max_health_point = 10
		sample_1.current_health_point = 0
		sample_1.attack = 10
		sample_1.defence = 10
		sample_1.speed = 10
		sample_1.current_experience = -1
		expect(sample_1.save).to eq(false)
		expect(sample_1.errors.include? :current_experience).to eq(true)
	end

	it "Pokemon's max HP should not be equal or lower than 0." do
		pokedex_sample_1 = ::Pokedex.new
		pokedex_sample_1.name = "Pokedess"
		pokedex_sample_1.base_health_point = 10
		pokedex_sample_1.base_attack = 10
		pokedex_sample_1.base_defence = 10
		pokedex_sample_1.base_speed = 10
		pokedex_sample_1.element_type = "ice"
		pokedex_sample_1.image_url = "metapod_image.png"
		expect(pokedex_sample_1.save).to eq(true)

		sample_1 = Pokemon.new
		sample_1.pokedex = pokedex_sample_1
		sample_1.name = 'Poke'
		sample_1.level = 1
		sample_1.max_health_point = 0
		sample_1.current_health_point = 0
		sample_1.attack = 10
		sample_1.defence = 10
		sample_1.speed = 10
		sample_1.current_experience = 0
		expect(sample_1.save).to eq(false)
		expect(sample_1.errors.include? :max_health_point).to eq(true)
	end

	it "Pokemon's attack and defence should not be equal or lower than 0." do
		pokedex_sample_1 = ::Pokedex.new
		pokedex_sample_1.name = "Pokedess"
		pokedex_sample_1.base_health_point = 10
		pokedex_sample_1.base_attack = 10
		pokedex_sample_1.base_defence = 10
		pokedex_sample_1.base_speed = 10
		pokedex_sample_1.element_type = "ice"
		pokedex_sample_1.image_url = "metapod_image.png"
		expect(pokedex_sample_1.save).to eq(true)

		sample_1 = Pokemon.new
		sample_1.pokedex = pokedex_sample_1
		sample_1.name = 'Poke'
		sample_1.level = 1
		sample_1.max_health_point = 0
		sample_1.current_health_point = 0
		sample_1.attack = 0
		sample_1.defence = 0
		sample_1.speed = 10
		sample_1.current_experience = 0
		expect(sample_1.save).to eq(false)
		expect(sample_1.errors.include?(:attack)).to eq(true)
		expect(sample_1.errors.include?(:defence)).to eq(true)
	end

	it "Pokemon's speed and level should not be equal or lower than 0." do
		pokedex_sample_1 = ::Pokedex.new
		pokedex_sample_1.name = "Pokedess"
		pokedex_sample_1.base_health_point = 10
		pokedex_sample_1.base_attack = 10
		pokedex_sample_1.base_defence = 10
		pokedex_sample_1.base_speed = 10
		pokedex_sample_1.element_type = "ice"
		pokedex_sample_1.image_url = "metapod_image.png"
		expect(pokedex_sample_1.save).to eq(true)

		sample_1 = Pokemon.new
		sample_1.pokedex = pokedex_sample_1
		sample_1.name = 'Poke'
		sample_1.level = 0
		sample_1.max_health_point = 0
		sample_1.current_health_point = 0
		sample_1.attack = 10
		sample_1.defence = 10
		sample_1.speed = 0
		sample_1.current_experience = 0
		expect(sample_1.save).to eq(false)
		expect(sample_1.errors.include?(:level)).to eq(true)
		expect(sample_1.errors.include?(:speed)).to eq(true)
	end

	it "Pokemon's pokemon_skills should not be nil" do
		pokedex_sample_1 = ::Pokedex.new
		pokedex_sample_1.name = "Pokedess"
		pokedex_sample_1.base_health_point = 10
		pokedex_sample_1.base_attack = 10
		pokedex_sample_1.base_defence = 10
		pokedex_sample_1.base_speed = 10
		pokedex_sample_1.element_type = "ice"
		pokedex_sample_1.image_url = "metapod_image.png"
		expect(pokedex_sample_1.save).to eq(true)

		sample_1 = Pokemon.new
		sample_1.pokedex = pokedex_sample_1
		sample_1.name = 'Poke'
		sample_1.level = 10
		sample_1.max_health_point = 100
		sample_1.current_health_point = 100
		sample_1.attack = 10
		sample_1.defence = 10
		sample_1.speed = 10
		sample_1.current_experience = 100
		expect(sample_1.save).to eq(true)
		expect(sample_1.pokemon_skills.nil?).to eq(false)
	end
end