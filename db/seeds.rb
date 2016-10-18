# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

100.times do |i|
	Skill.create(name: "Skill #{i}", power: 10, max_pp: 10, element_type: 'Grass')
	Pokedex.create(
	 image_url: "this is url",
	 name: "Pokedex #{i}",
	 base_attack: 100, 
	 base_defence: 100, 
	 base_speed: 100, 
	 base_health_point: 100, 
	 element_type: 'Fire')
end