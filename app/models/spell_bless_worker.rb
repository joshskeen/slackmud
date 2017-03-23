class SpellBlessWorker
  include Sidekiq::Worker
  def perform(room_id, room_message)
    slack_messenger.msg_room(room_id, room_message)
  end

  def slack_messenger
    SlackMessenger.new
  end
end
