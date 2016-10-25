class CreatePokemonBattleLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :pokemon_battle_logs do |t|
      t.integer :pokemon_battle_id
      t.integer :turn
      t.integer :skill_id
      t.integer :damage
      t.integer :attacker_id
      t.integer :attacker_current_health_point
      t.integer :defender_id
      t.integer :defender_current_health_point
      t.string :action_type
      t.timestamps
    end
  end
end
