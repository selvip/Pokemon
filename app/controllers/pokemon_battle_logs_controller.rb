class PokemonBattleLogsController < ApplicationController
	def index
		@pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
		@pokemon_battle_logs = @pokemon_battle.pokemon_battle_logs
		navigation_add("Pokemon Battle Index", pokemon_battles_path)
		navigation_add("Pokemon Battle Show", @pokemon_battle)
		navigation_add("Pokemon Battle Logs", "#")
	end
end