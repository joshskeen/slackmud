class AddUniqueNameToPlayers < ActiveRecord::Migration
  add_index :players, [:name], unique: true
end
