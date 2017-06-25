module ItemUtil
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods

    def wearable
      properties.where(name: Property::NAME_WEARABLE).first
    end

    def wearable?
      wearable.present?
    end

    def inventory_formatted_item
      I18n.t 'game.inventory_formatted_item', shortdesc: shortdesc
    end

  end
end
