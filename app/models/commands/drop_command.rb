class DropCommand < GameCommandBase
  include PlayerUtil

  def perform
    return I18n.t 'game.drop_command.no_item_matching' if !player_has_item?
    return I18n.t 'game.drop_command.no_quantity_found' if !player_has_quantity?
    transfer_item_to_room
    slack_messenger.msg_room(room.slackid, format_room_message)
    success_message
  end

  private

  def success_message
    if coin?
      return I18n.t 'game.drop_command.coin_success', qty: quantity
    else
      return I18n.t 'game.drop_command.success', itemname: item.shortdesc, qty: quantity
    end

  end

  def format_room_message
    if coin?
      return I18n.t 'game.drop_command.slack_coin_success',
             playername: player.name,
             qty: quantity
    else
      return I18n.t 'game.drop_command.slack_success',
             playername: player.name,
             itemname: item.shortdesc,
             qty: quantity
    end
  end
end
