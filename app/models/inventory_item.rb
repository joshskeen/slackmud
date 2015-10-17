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

  has_many :inventory_item_effects
  has_many :effects, through: :inventory_item_effects

  scope :wearable, lambda { |item = nil|
    where(item: item, worn: false)
  }
  scope :worn, lambda { |item = nil|
    where(item: item, worn: true)
  }

  scope :equipped, lambda {
    where(worn: true)
  }
end
