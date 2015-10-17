require 'rails_helper'

describe Command::InventoryCommand do
  let(:game) { double(Game::Game) }
  let(:game_command) { Command::GameCommand.new(game) }
  let(:slack_request) { double(Game::SlackRequest) }
  let(:slack_messenger) { double(Game::SlackMessenger) }

  let(:josh) { FactoryGirl.create(:player_with_inventory) }
  let(:aleck) { FactoryGirl.create(:player_aleck) }

  before(:each) do
    allow(game).to receive(:slack_request).and_return(slack_request)
  end

  describe 'inventory_display' do
    it 'shows a list of items possessed' do
      allow(game).to receive(:player).and_return(josh)
      allow(slack_request).to receive(:text).and_return('inventory')
      expect(game_command.perform).to eq "a black woolen tunic\nloaf of bread (2)\ncloak made from dryad skin\na purple wizardhat\na fedora made of pure crystal\n"
    end
    it 'shows nothing' do
      allow(game).to receive(:player).and_return(aleck)
      allow(slack_request).to receive(:text).and_return('inventory')
      expect(game_command.perform).to eq I18n.t 'game.inventory_command.nothing.'
    end
  end
end
