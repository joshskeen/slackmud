class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :gender
      t.text :description
      t.string :name
      t.string :slackid
      t.timestamps null: false
    end
    add_reference :players, :inventory, index: true
    add_index :players, [:slackid], unique: true
  end
end
