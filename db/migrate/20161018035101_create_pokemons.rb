class CreatePokemons < ActiveRecord::Migration[5.0]
  def change
    create_table :pokemons do |t|
      t.integer :pokedex_id
      t.string :name
      t.integer :level
      t.integer :max_health_point
      t.integer :current_health_point
      t.integer :attack
      t.integer :defence
      t.integer :speed
      t.integer :current_experience
      t.timestamps
    end
  end
end
