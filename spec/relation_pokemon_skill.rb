require 'spec_helper'
require 'rails_helper'
require 'pry'

describe 'relation to pokemon_skill' do
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

		@sample_skill = ::Skill.new
		@sample_skill.name = "Skill 1"
		@sample_skill.power = 10
		@sample_skill.max_pp = 10
		@sample_skill.element_type = 'dark'
		@sample_skill.save
	end

	it "pokemon_skill must be owned by a pokemon" do	
		ps_sample_1 = ::PokemonSkill.new
		ps_sample_1.pokemon_id = 1
		ps_sample_1.skill_id = @sample_skill.id
		ps_sample_1.current_pp = 10
		expect(ps_sample_1.save).to eq(false)
		expect(ps_sample_1.errors.include? :pokemon).to eq(true)
	end



	it "PokemonSkill must be owned by a skill" do
		ps_sample_1 = ::PokemonSkill.new
		ps_sample_1.pokemon_id = @sample_1.id
		ps_sample_1.current_pp = 10
		expect(ps_sample_1.skill.nil?).to eq(true)
	end

	it "PokemonSkill valid input" do
		ps_sample_1 = ::PokemonSkill.new
		ps_sample_1.pokemon_id = @sample_1.id
		ps_sample_1.skill_id = @sample_skill.id
		ps_sample_1.current_pp = 10
		expect(ps_sample_1.save).to eq(true)
	end


end
