require 'rails_helper'

describe Game::SlackRequest do
  let(:params) do
    {
      "token":  'IkuvaNzQIHg97ATvDxqgjtO',
      "channel_id": 'C2147483705',
      "text": 'booyah!'
    }
  end
  let(:game_request) { Game::SlackRequest.new(params) }

  it 'sets the params of the SlackRequest object' do
    expect(game_request.text).to eq 'booyah!'
  end
end
