require 'slack'

Slack.configure do |config|
  config.token = ENV["SLACK_API_KEY"]
end
