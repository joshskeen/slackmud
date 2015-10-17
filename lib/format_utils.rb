module FormatUtils
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    def format_inventory(items, inventory)
      items.distinct.map do |x|
        { item: x,
          count: InventoryItem.where(inventory: inventory,
                                     item: x).count }
      end
        .map do |x|
        template = x[:count] == 1 ? 'game.formatted_inventory' : 'game.formatted_inventory_count'
        I18n.t template,
               inventory: x[:item].shortdesc,
               count: x[:count]
      end.join
    end
  end
end
