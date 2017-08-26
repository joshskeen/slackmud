class SpellInviz < GameCommandBase
  include PlayerUtil

  def initialize(game)
    super(game)
  end

  def perform
    return I18n.t 'game.spell_inviz.no_target' if target? || slack_text_array.length == 2
    return I18n.t 'game.spell_inviz.not_found' if !room_has_player?
    slack_messenger.msg_room(room.slackid, room_message)
    target_player_in_room.effects << Effect.where(name: Effect::EFFECT_INVIZED)
    user_message
  end

  private

  def user_message
    I18n.t 'game.spell_inviz.success',
           target: target,
           playername: player.name
  end

  def room_message
    I18n.t 'game.spell_inviz.slack_success',
           target: target_player_in_room.name,
           playername: player.name
  end
end
