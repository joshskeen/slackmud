class AddImmortalToPlayers < ActiveRecord::Migration
  def change
    change_table :players do |t|
      t.column :immortal, :boolean, default: false
    end
  end
end
