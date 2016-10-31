# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
	require 'pry'
	require 'csv'
	
	csv_skill = File.read(Rails.root.join('lib', 'seeds', 'list_skill.csv'))
	csv = CSV.parse(csv_skill, headers: true)
	csv.each do |row|
		sk = Skill.new
		sk.name = row['name']
		sk.power = row['power']
		sk.max_pp = row['max_pp']
		sk.element_type = row['element_type']
		sk.save
	end
	puts "There are now #{Skill.count} rows in the Skill Table."

	csv_pokedex = File.read(Rails.root.join('lib', 'seeds', 'list_pokedex.csv'))
	csv = CSV.parse(csv_pokedex, headers: true)
	csv.each do |row|
		poke = Pokedex.new
		poke.name = row['name']
		poke.base_health_point = row['base_health_point']
		poke.base_attack = row['base_attack']
		poke.base_defence = row['base_defence']
		poke.base_speed = row['base_speed']
		poke.element_type = row['element_type']
		poke.image_url = row['image_url']
		poke.save
	end

	puts "There are now #{Pokedex.count} rows in the Pokedex Table."
>>>>>>> 76553ef309d5e281772bbeedb73a510e48a8aed2
