class CreateTableRoomPlayers < ActiveRecord::Migration
  def change
    create_table :room_players do |t|
      t.integer :player_id
      t.integer :room_id
    end
  end
end
