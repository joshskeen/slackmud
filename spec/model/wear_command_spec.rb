require 'rails_helper'

describe WearCommand do
  let(:game) { double(Game) }
  let(:game_command) { GameCommand.new(game) }
  let(:slack_request) { double(SlackRequest) }
  let(:slack_messenger) { double(SlackMessenger) }

  let(:room) { FactoryGirl.create(:room) }

  before(:each) do
    allow(game).to receive(:slack_request).and_return(slack_request)
    allow(game).to receive(:room).and_return(room)
  end

  describe 'success' do
    let(:game_player) { FactoryGirl.create(:player_with_inventory) }
    before(:each) do
      allow(game).to receive(:player).and_return(game_player)
      allow(game).to receive(:slack_messenger).and_return(slack_messenger)
    end

    it 'displays a success message' do
      allow(slack_request).to receive(:text).and_return('wear cloak')
      expect(slack_messenger).to receive(:msg_room).with(room.slackid, 'josh skeen wears cloak made from dryad skin on his neck.')
      expect(game_command.perform).to eq 'You wear cloak made from dryad skin on your neck.'
      allow(slack_request).to receive(:text).and_return('wear hat')
      expect(slack_messenger).to receive(:msg_room).with(room.slackid, 'josh skeen wears a purple wizardhat on his head.')
      expect(game_command.perform).to eq 'You wear a purple wizardhat on your head.'
    end

    it 'disallows wearing an item that isnt wearable' do
      allow(slack_request).to receive(:text).and_return('wear loaf')
      expect(game_command.perform).to eq "You can't wear that!"
    end

    it 'disallows wearing an item in the same slot twice' do
      allow(slack_request).to receive(:text).and_return('wear hat')
      expect(slack_messenger).to receive(:msg_room).with(room.slackid, 'josh skeen wears a purple wizardhat on his head.')
      expect(game_command.perform).to eq 'You wear a purple wizardhat on your head.'
      game_player.reload
      allow(slack_request).to receive(:text).and_return('wear fedora')
      expect(game_command.perform).to eq "You're already wearing something there (head)!"
    end
  end
end
