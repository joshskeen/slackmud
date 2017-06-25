module PlayerUtil

  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods

    def wear_item
      inventory_item = player.inventory.inventory_items.where(item_id: item.id).first
      inventory_item.worn = true
      inventory_item.save
    end

    def transfer_item_to_player
      player.remove_item(item, @quantity)
      target_player_in_room.add_item(item, @quantity)
    end

    def transfer_item_to_room
      player.remove_item(item, @quantity)
      room.add_item(item, @quantity)
    end

    def transfer_item_from_room
      room.remove_item(item, @quantity)
      player.add_item(item, @quantity)
    end

    def item
      Item.first_by_keyword(@arguments)
    end

    def room_item
      room.item(@arguments)
    end

    def player_item
      player.item(@arguments)
    end

    def player_has_item?
      player_item.present?
    end

    def room_has_player?
      !target_player_in_room.nil?
    end

    def target_player_in_room
      return @player if @target == "self"
      room.player_by_name(@target)
    end

    def player_has_quantity?
      player.has_quantity?(@arguments, @quantity)
    end

    def room_has_quantity?
      room.has_quantity?(@arguments, @quantity)
    end

  end

end
