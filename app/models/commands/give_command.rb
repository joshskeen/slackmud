class GiveCommand < GameCommandBase
  include PlayerUtil

  def initialize(game)
    super(game)
  end

  def perform
    return no_item_matching_error if !player_has_item?
    return I18n.t 'game.give_command.no_target' if target? || slack_text_array.length == 2
    return I18n.t 'game.give_command.target_not_found' if !room_has_player?
    return I18n.t 'game.give_command.quantity_not_found' if !player_has_quantity?
    transfer_item_to_player
    slack_messenger.msg_room(room.slackid, room_message)
    user_message
  end

  private

  def no_item_matching_error
    return I18n.t 'game.insufficient_funds' if coin?
    return I18n.t 'game.give_command.no_item_matching'
  end

  def user_message
    if coin?
      I18n.t 'game.give_command.coin_success',
        target: target_player_in_room.name,
        qty: @quantity
    else
      I18n.t 'game.give_command.success',
        itemdesc: item.shortdesc,
        target: target_player_in_room.name,
        qty: @quantity
    end
  end

  def room_message
    if coin?
      I18n.t 'game.give_command.slack_coin_success',
        name: player.name,
        target: target_player_in_room.name,
        qty: @quantity
    else
      I18n.t 'game.give_command.slack_success',
        name: player.name,
        itemdesc: item.shortdesc,
        target: target_player_in_room.name,
        qty: @quantity
    end
  end

end
