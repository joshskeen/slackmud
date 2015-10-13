class DropCommand < GameCommandBase
  include PlayerUtil

  def perform
    return I18n.t 'game.drop_command.no_item_matching' if !player_has_item?
    return I18n.t 'game.drop_command.no_quantity_found' if !player_has_quantity?
    transfer_item_to_room
    slack_messenger.msg_room(room.slackid, format_room_message)
    I18n.t 'game.drop_command.success', itemname: item.shortdesc, qty: quantity
  end

  private 

  def format_room_message
    I18n.t 'game.drop_command.slack_success',
      playername: player.name, 
      itemname: item.shortdesc,
      qty: quantity
  end

end
