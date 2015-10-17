module Command
  class GetCommand < GameCommandBase
    include PlayerUtil

    def perform
      return I18n.t 'game.get_command.no_item_matching' if room_missing_item?
      return I18n.t 'game.get_command.no_quantity_found' unless room_has_quantity?
      transfer_item_from_room
      slack_messenger.msg_room(room.slackid, format_room_message)
      I18n.t 'game.get_command.success', shortdesc: item.shortdesc
    end

    private

    def room_missing_item?
      !room
        .inventory
        .items
        .where(id: item)
        .first
        .present?
    end

    def format_room_message
      I18n.t 'game.get_command.slack_success',
             playername: player.name,
             shortdesc: item.shortdesc
    end
  end
end
