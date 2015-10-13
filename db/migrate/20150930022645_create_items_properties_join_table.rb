class CreateItemsPropertiesJoinTable < ActiveRecord::Migration
  def change
    create_table :item_properties do |t|
      t.integer :item_id
      t.integer :property_id
    end
  end
end
