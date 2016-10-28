require 'spec_helper'
require 'rails_helper'

describe 'Pokedex validation testing' do
	it 'Name must be present.' do
		pokedex_sample_1 = ::Pokedex.new
		pokedex_sample_1.name = ""
		pokedex_sample_1.base_health_point = 10
		pokedex_sample_1.base_attack = 10
		pokedex_sample_1.base_defence = 10
		pokedex_sample_1.base_speed = 10
		pokedex_sample_1.element_type = "ice"
		pokedex_sample_1.image_url = "metapod_image.png"
		expect(pokedex_sample_1.save).to eq(false)
		expect(pokedex_sample_1.errors.include?(:name)).to eq(true)
	end

	it 'Name must be unique.' do
		pokedex_sample_1 = ::Pokedex.new
		pokedex_sample_1.name = "Hijau"
		pokedex_sample_1.base_health_point = 10
		pokedex_sample_1.base_attack = 10
		pokedex_sample_1.base_defence = 10
		pokedex_sample_1.base_speed = 10
		pokedex_sample_1.element_type = "ice"
		pokedex_sample_1.image_url = "metapod_image.png"
		pokedex_sample_1.save

		pokedex_sample_2 = ::Pokedex.new
		pokedex_sample_2.name = "Hijau"
		pokedex_sample_2.base_health_point = 10
		pokedex_sample_2.base_attack = 10
		pokedex_sample_2.base_defence = 10
		pokedex_sample_2.base_speed = 10
		pokedex_sample_2.element_type = "ice"
		pokedex_sample_2.image_url = "metapod_image.png"
		expect(pokedex_sample_2.save).to eq(false)
		expect(pokedex_sample_2.errors.include?(:name)).to eq(true)
	end

	it 'Name length must not exceed 45 character.' do
		pokedex_sample_2 = ::Pokedex.new
		pokedex_sample_2.name = "Provides extra visual weight and identifies the primary action in a set of buttons"
		pokedex_sample_2.base_health_point = 10
		pokedex_sample_2.base_attack = 10
		pokedex_sample_2.base_defence = 10
		pokedex_sample_2.base_speed = 10
		pokedex_sample_2.element_type = "ice"
		pokedex_sample_2.image_url = "metapod_image.png"
		expect(pokedex_sample_2.save).to eq(false)
		expect(pokedex_sample_2.errors.include?(:name)).to eq(true)
	end

	it 'Base HP must be present.' do
		pokedex_sample_1 = ::Pokedex.new
		pokedex_sample_1.name = "Poke"
		pokedex_sample_1.base_health_point = ''
		pokedex_sample_1.base_attack = 10
		pokedex_sample_1.base_defence = 10
		pokedex_sample_1.base_speed = 10
		pokedex_sample_1.element_type = "ice"
		pokedex_sample_1.image_url = "metapod_image.png"
		expect(pokedex_sample_1.save).to eq(false)
		expect(pokedex_sample_1.errors.include?(:base_health_point)).to eq(true)
	end

	it 'Base HP should only be integer' do
		pokedex_sample_2 = ::Pokedex.new
		pokedex_sample_2.name = "Blue Color"
		pokedex_sample_2.base_health_point = [0.12434, 90]
		pokedex_sample_2.base_attack = 10
		pokedex_sample_2.base_defence = 10
		pokedex_sample_2.base_speed = 10
		pokedex_sample_2.element_type = "ice"
		pokedex_sample_2.image_url = "metapod_image.png"
		expect(pokedex_sample_2.save).to eq(false)
		expect(pokedex_sample_2.errors.include?(:base_health_point)).to eq(true)
	end

	it 'Base HP should be greater than 0.' do
		pokedex_sample_2 = ::Pokedex.new
		pokedex_sample_2.name = "Blue Color"
		pokedex_sample_2.base_health_point = -10
		pokedex_sample_2.base_attack = 10
		pokedex_sample_2.base_defence = 10
		pokedex_sample_2.base_speed = 10
		pokedex_sample_2.element_type = "ice"
		pokedex_sample_2.image_url = "metapod_image.png"
		expect(pokedex_sample_2.save).to eq(false)
		expect(pokedex_sample_2.errors.include?(:base_health_point)).to eq(true)
	end

	it 'Base Attack should only be integer' do
		pokedex_sample_2 = ::Pokedex.new
		pokedex_sample_2.name = "Blue Color"
		pokedex_sample_2.base_health_point = 10
		pokedex_sample_2.base_attack = 10.232321
		pokedex_sample_2.base_defence = 10
		pokedex_sample_2.base_speed = 10
		pokedex_sample_2.element_type = "ice"
		pokedex_sample_2.image_url = "metapod_image.png"
		expect(pokedex_sample_2.save).to eq(false)
		expect(pokedex_sample_2.errors.include?(:base_attack)).to eq(true)
	end

	it 'Base Attack should be greater than 0.' do
		pokedex_sample_2 = ::Pokedex.new
		pokedex_sample_2.name = "Blue Color"
		pokedex_sample_2.base_health_point = 10
		pokedex_sample_2.base_attack = -210
		pokedex_sample_2.base_defence = 10
		pokedex_sample_2.base_speed = 10
		pokedex_sample_2.element_type = "ice"
		pokedex_sample_2.image_url = "metapod_image.png"
		expect(pokedex_sample_2.save).to eq(false)
		expect(pokedex_sample_2.errors.include?(:base_attack)).to eq(true)
	end

	it 'Base Defence Point should only be integer' do
		pokedex_sample_2 = ::Pokedex.new
		pokedex_sample_2.name = "Blue Color"
		pokedex_sample_2.base_health_point = 10
		pokedex_sample_2.base_attack = 10
		pokedex_sample_2.base_defence = 10.35
		pokedex_sample_2.base_speed = 10
		pokedex_sample_2.element_type = "ice"
		pokedex_sample_2.image_url = "metapod_image.png"
		expect(pokedex_sample_2.save).to eq(false)
		expect(pokedex_sample_2.errors.include?(:base_defence)).to eq(true)
	end

	it 'Base Defence Point should only be greater than 0.' do
		pokedex_sample_2 = ::Pokedex.new
		pokedex_sample_2.name = "Blue Color"
		pokedex_sample_2.base_health_point = 10
		pokedex_sample_2.base_attack = 10
		pokedex_sample_2.base_defence = 0
		pokedex_sample_2.base_speed = 10
		pokedex_sample_2.element_type = "ice"
		pokedex_sample_2.image_url = "metapod_image.png"
		expect(pokedex_sample_2.save).to eq(false)
		expect(pokedex_sample_2.errors.include?(:base_defence)).to eq(true)
	end

	it 'Base Speed should only be integer' do
		pokedex_sample_2 = ::Pokedex.new
		pokedex_sample_2.name = "Blue Color"
		pokedex_sample_2.base_health_point = 10
		pokedex_sample_2.base_attack = 10
		pokedex_sample_2.base_defence = 10
		pokedex_sample_2.base_speed = 1.50
		pokedex_sample_2.element_type = "ice"
		pokedex_sample_2.image_url = "metapod_image.png"
		expect(pokedex_sample_2.save).to eq(false)
		expect(pokedex_sample_2.errors.include?(:base_speed)).to eq(true)
	end

	it 'Base Speed should be greater than 0.' do
		pokedex_sample_2 = ::Pokedex.new
		pokedex_sample_2.name = "Blue Color"
		pokedex_sample_2.base_health_point = 10
		pokedex_sample_2.base_attack = 10
		pokedex_sample_2.base_defence = 10
		pokedex_sample_2.base_speed = 0
		pokedex_sample_2.element_type = "ice"
		pokedex_sample_2.image_url = "metapod_image.png"
		expect(pokedex_sample_2.save).to eq(false)
		expect(pokedex_sample_2.errors.include?(:base_speed)).to eq(true)
	end

	it 'Base Speed should only be integer' do
		pokedex_sample_2 = ::Pokedex.new
		pokedex_sample_2.name = "Blue Color"
		pokedex_sample_2.base_health_point = 10
		pokedex_sample_2.base_attack = 10
		pokedex_sample_2.base_defence = 10
		pokedex_sample_2.base_speed = 1.50
		pokedex_sample_2.element_type = "ice"
		pokedex_sample_2.image_url = "metapod_image.png"
		expect(pokedex_sample_2.save).to eq(false)
		expect(pokedex_sample_2.errors.include?(:base_speed)).to eq(true)
	end

	it 'Base Speed should only be integer' do
		pokedex_sample_2 = ::Pokedex.new
		pokedex_sample_2.name = "Blue Color"
		pokedex_sample_2.base_health_point = 10
		pokedex_sample_2.base_attack = 10
		pokedex_sample_2.base_defence = 10
		pokedex_sample_2.base_speed = 10
		pokedex_sample_2.element_type = "coca-cola"
		pokedex_sample_2.image_url = "metapod_image.png"
		expect(pokedex_sample_2.save).to eq(false)
		expect(pokedex_sample_2.errors.include?(:element_type)).to eq(true)
	end

end