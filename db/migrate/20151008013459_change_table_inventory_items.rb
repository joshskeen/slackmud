class ChangeTableInventoryItems < ActiveRecord::Migration
  def change
    change_table :inventory_items do |t|
      t.column :worn, :boolean, default: false
    end
  end
end
