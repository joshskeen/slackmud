class EatCommand < GameCommandBase
  include PlayerUtil

  def perform
    return I18n.t 'game.eat_command.no_item_matching' if !player_has_item?
    return I18n.t 'game.eat_command.inedible' if !item_edible?
    slack_messenger.msg_room(room.slackid, format_room_message)
    player.remove_item(item, 1)
    I18n.t 'game.eat_command.success', shortdesc: item.shortdesc, 
      actiontype: actiontype
  end

  private

  def item_edible?
    item.fetch_property("edible").present?
  end

  def actiontype
    item.fetch_property("edible").value == "food" ? "eat" : "drink"
  end

  def format_room_message
    I18n.t 'game.eat_command.slack_success',
      playername: player.name, 
      actiontype: actiontype,
      shortdesc: item.shortdesc
  end

end
