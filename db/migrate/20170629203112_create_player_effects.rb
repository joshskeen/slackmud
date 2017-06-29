class CreatePlayerEffects < ActiveRecord::Migration
  def change
    create_table :player_effects do |t|
      t.integer :player_id
      t.integer :effect_id
    end
    add_index :player_effects, [:player_id, :effect_id], unique: true
  end
end
