module Command
  class RemoveCommand < GameCommandBase
    include PlayerUtil

    def perform
      return I18n.t 'game.remove_command.not_worn' unless item_worn?
      remove_item
      slack_messenger.msg_room(room.slackid, room_message)
      I18n.t 'game.remove_command.success', itemname: item.shortdesc
    end

    private

    def room_message
      I18n.t 'game.remove_command.slack_success',
             itemname: item.shortdesc,
             playername: player.name
    end

    def item_worn?
      player.inventory.worn.where(id: item).present?
    end

    def remove_item
      inventory_item = player.inventory.inventory_items.where(item_id: item, worn: true).first
      inventory_item.worn = false
      inventory_item.save
    end

    def slot_occupied?
      occupied_slots.include? wearable_slot
    end
  end
end
