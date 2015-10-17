module Game
  class SlackRequest
    def initialize(params)
      @params = params
    end

    def channel_id
      @params[:channel_id].to_s
    end

    def text
      @params[:text].to_s
    end

    def slackid
      @params[:user_id].to_s
    end

    def slackname
      @params[:user_name]
    end
  end
end
