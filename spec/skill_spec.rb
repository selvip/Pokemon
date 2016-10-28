require 'spec_helper'
require 'rails_helper'
require 'pry'

describe "Skill validation testing" do
	it "Sample of true input" do
		sample_1 = ::Skill.new
		sample_1.name = "Skill 1"
		sample_1.power = 10
		sample_1.max_pp = 10
		sample_1.element_type = 'dark'
		expect(sample_1.save).to eq(true)
	end

	it "Name should not be blank." do
		sample_1 = ::Skill.new
		sample_1.name = ""
		sample_1.power = 10
		sample_1.max_pp = 10
		sample_1.element_type = 'dark'
		expect(sample_1.save).to eq(false)
		expect(sample_1.errors.include? :name).to eq(true)
	end	

	it "Power should be integer" do
		sample_1 = ::Skill.new
		sample_1.name = "Skill 1"
		sample_1.power = 10.12
		sample_1.max_pp = 10
		sample_1.element_type = 'dark'
		expect(sample_1.save).to eq(false)
		expect(sample_1.errors.include? :power).to eq(true)
	end

	it "Power should be 0 at least." do
		sample_1 = ::Skill.new
		sample_1.name = "Skill 1"
		sample_1.power = -89
		sample_1.max_pp = 10
		sample_1.element_type = 'dark'
		expect(sample_1.save).to eq(false)
		expect(sample_1.errors.include? :power).to eq(true)
	end
	
	it "Max PP should be integer." do
		sample_1 = ::Skill.new
		sample_1.name = "Skill 1"
		sample_1.power = 89
		sample_1.max_pp = "string"
		sample_1.element_type = 'dark'
		expect(sample_1.save).to eq(false)
		expect(sample_1.errors.include? :max_pp).to eq(true)
	end

	it "Max PP should be 0 at least." do
		sample_1 = ::Skill.new
		sample_1.name = "Skill 1"
		sample_1.power = 89
		sample_1.max_pp = -10
		sample_1.element_type = 'dark'
		expect(sample_1.save).to eq(false)
		expect(sample_1.errors.include? :max_pp).to eq(true)
	end

	it "Element should be listed on Skill::ELEMENT." do
		sample_1 = ::Skill.new
		sample_1.name = "Skill 1"
		sample_1.power = 89
		sample_1.max_pp = 10
		sample_1.element_type = 'coca cola'
		expect(sample_1.save).to eq(false)
		expect(sample_1.errors.include? :element_type).to eq(true)
	end

end