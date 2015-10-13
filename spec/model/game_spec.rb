require 'spec_helper'
require 'game'
require 'slack_request'

describe 'Game' do
  let(:params){
    double("params")
  }
  let(:slack_request_params) {
    {
      "token":  "IkuvaNzQIHg97ATvDxqgjtO", 
      "channel_id": "C2147483705",
      "user_id": "1234",
      "text": :command,
      "user_name": "josh skeen"
    }
  }

  let(:command){
    "booyah" 
  }

  let(:game){
    Game.new(params)
  }

  before :each do
    allow(params).to receive(:request).and_return(slack_request_params)
  end

  describe 'player',vcr: true  do

    it 'creates a player for the slack request if none is found' do 
      expect(game.player.name).to eq "josh skeen"
    end

  end

  describe 'commands' do

    describe 'help' do
      let(:command){
        "help"
      }

    end

  end

end
