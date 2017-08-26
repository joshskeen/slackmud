class VizCommand < GameCommandBase
  include PlayerUtil

  def perform
    return already_visible_message unless player.invisible?
    make_visible
    slack_messenger.msg_room(room.slackid, format_room_message)
    I18n.t 'game.viz_command.success'
  end

  private

  def make_visible
    player.effects.delete(Effect.where(name: Effect::EFFECT_INVIZED))
  end

  def already_visible_message
    I18n.t 'game.viz_command.not_invized'
  end

  def format_room_message
    I18n.t 'game.viz_command.slack_success', playername: player.name
  end
end
