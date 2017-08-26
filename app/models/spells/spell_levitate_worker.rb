class SpellLevitateWorker
  include Sidekiq::Worker

  def perform(room_id, player_id, room_message)
    remove_flight(player_id)
    slack_messenger.msg_room(room_id, room_message)
  end

  def slack_messenger
    SlackMessenger.new
  end

  def remove_flight(player_id)
    Player.find(player_id).effects.delete(Effect.where(name: Effect::EFFECT_FLYING))
  end
end
