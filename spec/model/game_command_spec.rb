require 'rails_helper'

describe Command::GameCommandBase do

  include_context 'game state'

  let(:text) do
    'give 2 obsidian dagger josh'
  end

  before(:each) do
    allow(game).to receive(:slack_request).and_return(slack_request)
    allow(game).to receive(:player).and_return(player)
    allow(game).to receive(:room).and_return(room)
    allow(slack_request).to receive(:text).and_return(text)
  end

  describe 'text processing' do
    it 'parses command' do
      expect(game_command.command).to eq 'give'
    end

    it 'parses quantity' do
      expect(game_command.quantity).to eq 2
    end

    it 'parses argument' do
      expect(game_command.arguments).to eq 'obsidian dagger'
    end

    it 'parses target' do
      expect(game_command.target).to eq 'josh'
    end

    it 'parses target' do
      expect(game_command.target).to eq 'josh'
    end
  end

  describe 'game objects' do
    it 'references player' do
      expect(game_command.player).to eq player
    end

    it 'references room' do
      expect(game_command.room).to eq room
    end
  end
end
