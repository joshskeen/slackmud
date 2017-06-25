class GiveCommand < GameCommandBase
  include PlayerUtil

  def initialize(game)
    super(game)
  end

  def perform
    return I18n.t 'game.give_command.no_item_matching' if !player_has_item?
    return I18n.t 'game.give_command.no_target' if target? || slack_text_array.length == 2
    return I18n.t 'game.give_command.target_not_found' if !room_has_player?
    return I18n.t 'game.give_command.quantity_not_found' if !player_has_quantity?
    transfer_item_to_player
    slack_messenger.msg_room(room.slackid, room_message)
    user_message 
  end

  private

  def user_message 
    return I18n.t 'game.give_command.success', 
      itemdesc: item.shortdesc, 
      target: target_player_in_room.name, 
      qty: @quantity
  end

  def room_message
    I18n.t 'game.give_command.slack_success', 
      name: player.name,
      itemdesc: item.shortdesc, 
      target: target_player_in_room.name, 
      qty: @quantity
  end

end
