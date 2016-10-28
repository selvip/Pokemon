class CreatePokemonBattles < ActiveRecord::Migration[5.0]
  def change
    create_table :pokemon_battles do |t|
    	t.integer :pokemon1_id
    	t.integer :pokemon2_id
    	t.integer :current_turn
    	t.string :state
    	t.integer :pokemon_winner_id
    	t.integer :pokemon_loser_id
    	t.integer :experience_gain
    	t.integer :pokemon1_max_health_point
    	t.integer :pokemon2_max_health_point
      t.string :battle_type
      t.timestamps
    end
  end
end
