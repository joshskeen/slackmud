class Api::V1::GameController < ActionController::API
  include Game
  def create
    render text: Game.new(self).perform
  end
end
