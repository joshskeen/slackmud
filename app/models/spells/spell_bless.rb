class SpellBless < GameCommandBase
  include PlayerUtil

  def initialize(game)
    super(game)
  end

  def perform
    return I18n.t 'game.spell_bless.no_target' if target? || slack_text_array.length == 2
    return I18n.t 'game.spell_bless.target_not_found' if !room_has_player?
    slack_messenger.msg_room(room.slackid, room_message)
    SpellWorker.perform_in(3.seconds.from_now, room.slackid, blessed_message)
    SpellWorker.perform_in(2.minutes.from_now, room.slackid, bless_fade_message)
    user_message
  end

  private

  def bless_fade_message
    I18n.t 'game.spell_bless.bless_fade_message',
      target: target_player_in_room.name
  end

  def blessed_message
    I18n.t 'game.spell_bless.blessed_message',
      target: target_player_in_room.name,
      target_gender: target_player_in_room.third_person_subject.capitalize
  end

  def user_message
    I18n.t 'game.spell_bless.success',
      target: target,
      playername: player.name
  end

  def room_message
    I18n.t 'game.spell_bless.slack_success',
      target: target,
      playername: player.name
  end

end
