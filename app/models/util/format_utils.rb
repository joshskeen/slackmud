module FormatUtils

  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods

    def format_inventory(items, inventory)
      items.distinct.map{ |x| {item: x,
                                   count: InventoryItem.where(inventory: inventory,
                                                              item: x).count} }
        .map{ |x|
        template = x[:count] == 1 ? 'game.formatted_inventory' : 'game.formatted_inventory_count'
        I18n.t template,
          inventory: x[:item].shortdesc, 
          count: x[:count]
      }.join
    end

  end

end
