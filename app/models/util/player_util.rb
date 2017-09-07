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
      if coin?
        player.remove_funds(@quantity)
        target_player_in_room.add_funds(@quantity)
      else
        player.remove_item(item, @quantity)
        target_player_in_room.add_item(item, @quantity)
      end
    end

    def transfer_item_to_room
      if coin?
        player.remove_funds(@quantity)
        room.add_funds(@quantity)
      else
        player.remove_item(item, @quantity)
        room.add_item(item, @quantity)
      end
    end

    def transfer_item_from_room
      if coin?
        room.remove_funds(@quantity)
        player.add_funds(@quantity)
      else
        room.remove_item(item, @quantity)
        player.add_item(item, @quantity)
      end
    end

    def item
      Item.first_by_keyword(@arguments)
    end

    def room_item
      room.item(@arguments)
    end

    def coin?
      (@arguments =~ /coin/) != nil
    end

    def player_item
      return player.item(@arguments) unless coin?
      player.has_funds?(@quantity)
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
      return player.has_quantity?(@arguments, @quantity) unless coin?
      player.has_funds?(@quantity)
    end

    def room_has_quantity?
      return room.has_quantity?(@arguments, @quantity) unless coin?
      room.has_funds?(@quantity)
    end

  end

end
