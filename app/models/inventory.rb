# == Schema Information
#
# Table name: inventories
#
#  id        :integer          not null, primary key
#  nerdcoins :integer          default(0)
#

class Inventory < ActiveRecord::Base
  has_many :inventory_items
  has_many :items, through: :inventory_items

  has_many :edible_items,
           -> { edible },
           class_name: 'Item',
           source: :item,
           through: :inventory_items
  has_many :wearable_items,
           -> { wearable },
           class_name: 'Item',
           source: :item,
           through: :inventory_items
  has_many :items_unworn, -> { where worn: false }, class_name: 'InventoryItem'
  has_many :items_worn, -> { where worn: true }, class_name: 'InventoryItem'
  has_many :unworn, through: :items_unworn, class_name: 'Item', source: :item
  has_many :worn, through: :items_worn, class_name: 'Item', source: :item

  def by_keyword(keyword)
    Inventory.where(id: id).first.items.by_keyword(keyword).first
  end

  def no_items?
    items.empty?
  end

  def wearable?(item)
    inventory_items.wearable(item).count > 0
  end

  def remove_item(item, qty)
    InventoryItem.delete(Inventory.where(id: id).first.inventory_items.where(item_id: item.id).limit(qty))
  end

  def remove_funds(qty)
    inventory = Inventory.find(id)
    balance = [inventory.nerdcoins -= qty, 0].max
    inventory.update(nerdcoins: balance)
  end

  def add_funds(qty)
    inventory = Inventory.find(id)
    inventory.update(nerdcoins: inventory.nerdcoins += qty)
  end

  def has_funds?(qty)
    nerdcoins >= qty
  end

  def possesses?(item, qty)
    items.where(id: item.id).count >= qty
  end

  def add_item(item, qty)
    values = [].fill({ inventory_id: id, item_id: item.id }, 0, qty)
    InventoryItem.create(values)
  end

  def has_quantity?(keyword, qty)
    items.by_keyword(keyword).count >= qty
  end

  def has_item?(keyword)
    Inventory.where(id: id).first.items.by_keyword(keyword).first.present?
  end
end
