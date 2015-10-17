class CreatePlayerEffects < ActiveRecord::Migration
  def change
    create_table :player_effects do |t|
      t.integer :player_id
      t.integer :effect_id
    end
  end
end
