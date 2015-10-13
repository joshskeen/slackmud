require 'rails_helper'

describe 'Slack Request' do

  let(:params) {
    {
      "token":  "IkuvaNzQIHg97ATvDxqgjtO", 
      "channel_id": "C2147483705",
      "text": "booyah!"
    }
  }
  let(:game_request) { SlackRequest.new(params)}

  it "sets the params of the SlackRequest object" do
    expect(game_request.text).to eq "booyah!"
  end

end
