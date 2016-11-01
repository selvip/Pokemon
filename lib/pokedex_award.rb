class PokedexAward
	def initialize(element_type:)
		@element_type = element_type
	end

	def level
		query_for_show = ActiveRecord::Base.connection.execute(
			"select pokedexes.id, pokedexes.name, max(pokemons.level) as max_level
			from pokemons, pokedexes
			where pokemons.pokedex_id = pokedexes.id and pokedexes.element_type = '#{@element_type}'
			group by pokedexes.id, pokedexes.name
			order by max_level desc").to_a
		@best_pokedexes = []
		query_for_show.each do |pokedex|
			h = {}
			h[:pokedex] = Pokedex.find(pokedex["id"])
			h[:level] = pokedex["max_level"]
			@best_pokedexes << h
		end
		@best_pokedexes
	end

	def all_normal_pokedex
		query_for_show = ActiveRecord::Base.connection.execute(
			"select pokedexes.id
			from pokedexes
			where pokedexes.element_type = '#{@element_type}'").to_a
		@all_pokedexes = []
		query_for_show.each do |pokedex|
			h = {}
			h[:pokedex] = Pokedex.find(pokedex["id"])
			@all_pokedexes << h
		end
		@all_pokedexes
	end
end