class CreatePlayerRoomEffects < ActiveRecord::Migration
  def change
    create_table :player_room_effects do |t|
      t.integer :player_id
      t.integer :room_id
      t.string :effect
    end
  end
end
