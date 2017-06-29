class SpellLevitate < GameCommandBase
  include PlayerUtil

  def initialize(game)
    super(game)
  end

  def perform
    return I18n.t 'game.spell_levitate.no_target' if target? || slack_text_array.length == 2
    return I18n.t 'game.spell_levitate.target_not_found' if !room_has_player?
    slack_messenger.msg_room(room.slackid, room_message)
    SpellLevitateWorker.perform_in(3.minutes.from_now, room.slackid, target_player_in_room.id, levitate_fade_message)
    user_message
  end

  private

  def levitate_fade_message
    I18n.t 'game.spell_levitate.fade_message',
      target: target_player_in_room.name
  end

  def user_message
    I18n.t 'game.spell_levitate.success',
      target: target,
      playername: player.name
  end

  def room_message
    I18n.t 'game.spell_levitate.slack_success',
      target: target,
      playername: player.name
  end

end
