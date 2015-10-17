module Game
  class SlackMessenger
    def initialize
      @client = Slack::Client.new
    end

    def msg_room(channel_id, msg)
      @client.chat_postMessage(
        username: 'SlackMUD',
        text: msg,
        channel: channel_id
      )
    end
  end
end
