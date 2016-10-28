class PokemonBattleLog < ApplicationRecord
	belongs_to :pokemon_battle

	def skill_name
		PokemonSkill.find(self.skill_id).skill_name
	end

	def attacker_name
		Pokemon.find(self.attacker_id).name
	end

	def defender_name
		Pokemon.find(self.defender_id).name
	end
end
