class GetCommand < GameCommandBase
  include PlayerUtil

  def perform
    return I18n.t 'game.get_command.no_item_matching' if room_missing_item?
    return I18n.t 'game.get_command.no_quantity_found' if !room_has_quantity?
    transfer_item_from_room
    slack_messenger.msg_room(room.slackid, format_room_message)
    success_message
  end

  private
  
  def success_message
    return I18n.t 'game.get_command.success', shortdesc: item.shortdesc unless coin?
    return I18n.t 'game.get_command.coin_success', qty: quantity
  end

  def room_missing_item?
    if coin?
      return room.nerdcoins == 0
    else
      return !room
        .inventory
        .items
        .where(id: item)
        .first
        .present?
    end
  end

  def format_room_message
    if coin?
      return I18n.t 'game.get_command.slack_coin_success',
        playername: player.name,
        qty: quantity
    else
      return I18n.t 'game.get_command.slack_success',
        playername: player.name,
        shortdesc: item.shortdesc
    end
  end

end
