class PokemonBattleLogsController < ApplicationController
	def index
		@pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
		@pokemon_battle_logs = @pokemon_battle.pokemon_battle_logs
	end
end