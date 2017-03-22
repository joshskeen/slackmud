class AddIndexToRooms < ActiveRecord::Migration
  def change
    add_index :rooms, [:slackid], unique: true
  end
end
