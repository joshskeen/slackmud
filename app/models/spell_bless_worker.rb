class SpellBlessWorker
  include Sidekiq::Worker
  def perform(room_id, room_message)
    slack_messenger = SlackMessenger.new
    slack_messenger.msg_room(room_id, room_message)
  end
end
