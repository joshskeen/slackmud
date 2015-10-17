module PlayerUtil
  def self.included(base)
    base.send :include, InstanceMethods
  end

  class SubjectFinder < SimpleDelegator
    def initialize(game_command:)
      super(game_command)
    end

    def player_by_name
      room.players.by_name(arguments).first
    end

    def perform
      return room if looks_room?
      return player if arguments == 'self'
      return player_by_name if arguments.present? && player_by_name.present?
      return player_item if player_item.present?
      return room_item if room_item.present?
    end
  end

  module InstanceMethods
    def looks_room?
      arguments.blank? || arguments == 'room'
    end

    def looks_self?
      @found_subject == player
    end

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
