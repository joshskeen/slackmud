class CreateInventoryItemEffects < ActiveRecord::Migration
  def change
    create_table :inventory_item_effects do |t|
      t.integer :inventory_item_id
      t.integer :effect_id
    end
  end
end
