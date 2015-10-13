# == Schema Information
#
# Table name: inventory_items
#
#  id           :integer          not null, primary key
#  item_id      :integer
#  inventory_id :integer
#  worn         :boolean          default(FALSE)
#

class InventoryItem < ActiveRecord::Base

  belongs_to :inventory
  belongs_to :item

  scope :wearable, -> (item = nil) {
    where(item: item, worn: false)
  }
  scope :worn, -> (item = nil){
    where(item: item, worn: true)
  }

  scope :equipped, -> {
    where(worn: true)
  }

end
