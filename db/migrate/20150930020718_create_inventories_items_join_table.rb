class CreateInventoriesItemsJoinTable < ActiveRecord::Migration
  def change
    create_table :inventory_items do |t|
      t.integer :item_id
      t.integer :inventory_id
    end
  end
end
