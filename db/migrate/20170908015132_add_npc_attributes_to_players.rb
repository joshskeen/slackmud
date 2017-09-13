class AddNpcAttributesToPlayers < ActiveRecord::Migration
  def change
    change_table :players do |t|
      t.column :shortdesc, :text
      t.column :npc, :boolean, default:false
      t.column :shopkeeper, :boolean, default:false
    end
  end
end
