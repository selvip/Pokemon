require 'spec_helper'
require 'rails_helper'
require 'pry'

describe 'relation to pokemon_skill' do
	it "pokemon_skill must be owned by a pokemon" do
		sample_1 = PokemonSkill.new
		sample_1.pokemon_id = 1201
		sample_1.skill_id = 1
		sample_1.current_pp = 10
		expect(sample_1.save).to eq(false)
		expect(sample_1.errors.include? :pokemon_id).to eq(true)
	end
end