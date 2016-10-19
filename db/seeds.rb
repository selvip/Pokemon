# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |i|
	Skill.create(
		name: "Skill #{i}", 
		power: 10, 
		max_pp: 10, 
		element_type: 'Grass')
	Pokedex.create(
	 image_url: "http://vignette3.wikia.nocookie.net/youtubepoop/images/4/4c/Pokeball.png/revision/latest?cb=20150418234807",
	 name: "Sebut Saja Pokedex #{i}",
	 base_attack: 100, 
	 base_defence: 100, 
	 base_speed: 100, 
	 base_health_point: 100, 
	 element_type: 'Fire')
	
	Pokemon.create(
	pokedex_id: i+1,
	name: Pokedex.find(i+1).name,
	level: 1,
	max_health_point: Pokedex.find(i+1).base_health_point,
	current_health_point: Pokedex.find(i+1).base_health_point,
	attack: Pokedex.find(i+1).base_attack,
	defence: Pokedex.find(i+1).base_defence,
	speed: Pokedex.find(i+1).base_speed,
	current_experience: 0)
end