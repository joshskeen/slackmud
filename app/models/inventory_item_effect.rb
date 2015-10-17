class InventoryItemEffect < ActiveRecord::Base
  belongs_to :inventory_item
  belongs_to :effect
end
