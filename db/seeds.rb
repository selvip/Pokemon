# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

	Skill.create(
		name: "Poison Sting", 
		power: 15, 
		max_pp: 35, 
		element_type: 'poison')
	Skill.create(
		name: "Leech Life", 
		power: 20, 
		max_pp: 15, 
		element_type: 'bug')
	Skill.create(
		name: "Peck", 
		power: 35, 
		max_pp: 35, 
		element_type: 'flying')
	Skill.create(
		name: "Rage", 
		power: 20, 
		max_pp: 20, 
		element_type: 'normal')
	Skill.create(
		name: "Lick", 
		power: 30, 
		max_pp: 30, 
		element_type: 'ghost')
	Skill.create(
		name: "Water Gun", 
		power: 40, 
		max_pp: 25, 
		element_type: 'water')
	Skill.create(
		name: "Bite", 
		power: 60, 
		max_pp: 25, 
		element_type: 'dark')
	Skill.create(
		name: "Confusion", 
		power: 50, 
		max_pp: 15, 
		element_type: 'psychic')


	Pokedex.create(
	 image_url: "http://cdn.bulbagarden.net/upload/thumb/2/21/001Bulbasaur.png/250px-001Bulbasaur.png",
	 name: "Bulbasaur",
	 base_attack: 49, 
	 base_defence: 49, 
	 base_speed: 65, 
	 base_health_point: 45, 
	 element_type: 'grass')
	Pokedex.create(
	 image_url: "http://cdn.bulbagarden.net/upload/thumb/3/39/007Squirtle.png/250px-007Squirtle.png",
	 name: "Squirtle",
	 base_attack: 100, 
	 base_defence: 100, 
	 base_speed: 100, 
	 base_health_point: 44, 
	 element_type: 'dark')
	Pokedex.create(
	 image_url: "http://vignette3.wikia.nocookie.net/youtubepoop/images/4/4c/Pokeball.png/revision/latest?cb=20150418234807",
	 name: "Sebut Saja Pokedex #{i}",
	 base_attack: 100, 
	 base_defence: 100, 
	 base_speed: 100, 
	 base_health_point: 100, 
	 element_type: 'dark')	
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

