class BaseWorker
  include Sidekiq::Worker

  def slack_messenger
    SlackMessenger.new
  end

end
