class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :title
      t.text :description
      t.text :slackid
      t.integer :inventory_id
    end
  end
end
