require 'spec_helper'

describe 'Game' do
  let(:params) do
    double('params')
  end
  let(:slack_request_params) do
    {
      "token":  'IkuvaNzQIHg97ATvDxqgjtO',
      "channel_id": 'C2147483705',
      "user_id": '1234',
      "text": :command,
      "user_name": 'josh skeen'
    }
  end

  let(:command) do
    'booyah'
  end

  let(:game) do
    Game::Game.new(params)
  end

  before :each do
    allow(params).to receive(:request).and_return(slack_request_params)
  end

  describe 'player', vcr: true do
    it 'creates a player for the slack request if none is found' do
      expect(game.player.name).to eq 'josh skeen'
    end
  end

  describe 'commands' do
    describe 'help' do
      let(:command) do
        'help'
      end
    end
  end
end
