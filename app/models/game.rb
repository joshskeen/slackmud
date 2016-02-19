
class Game

  attr_accessor :player, :slack_request, :room, :slack_messenger

  def initialize(params)
    @slack_request = SlackRequest.new(params.request)
    @player = Player.find_or_create_player_by_slack_request(@slack_request)
    @room = Room.find_or_create_by_slackid(@slack_request.channel_id)
    @slack_api = Slack::Client.new
    @game_command = GameCommand.new(self)
    @slack_messenger = SlackMessenger.new
  end

  def perform
    @game_command.perform
  end

end
