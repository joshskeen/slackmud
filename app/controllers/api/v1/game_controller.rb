class Api::V1::GameController < ActionController::API
  def create
    render text: Game.new(self).perform
  end
end
