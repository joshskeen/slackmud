
require 'rails_helper'

describe ListCommand do

  let(:game){ double(Game) }
  let(:game_command){ GameCommand.new(game) }
  let(:slack_request){ double(SlackRequest) }
  let(:slack_messenger){double(SlackMessenger)}
  let!(:cake){FactoryGirl.create(:item_birthday_cake)}
  let!(:cake){FactoryGirl.create(:item_klondike)}

  let(:josh){ FactoryGirl.create(:player_with_inventory)}
  let(:shopkeeper){ FactoryGirl.create(:player_shopkeeper_lars)}

  let(:room){ FactoryGirl.create(:room, players: [josh, shopkeeper])}
  let(:room_no_keeper){ FactoryGirl.create(:room, slackid: 'test', players: [josh])}
  before(:each){
    allow(game).to receive(:slack_request).and_return(slack_request)
    allow(game).to receive(:player).and_return(josh)
    allow(game).to receive(:room).and_return(room)
  }

  describe 'with no shopkeeper' do
    before(:each) do
      allow(game).to receive(:room).and_return(room_no_keeper)
    end

    it 'says no shopkeeper found' do
      allow(slack_request).to receive(:text).and_return("list")
      expect(game_command.perform).to eq "You dont see a shopkeeper here."
    end
  end

  describe 'with a single shopkeeper present' do
    it "shows a list of items for purchase" do
      allow(slack_request).to receive(:text).and_return("list")
      expect(game_command.perform).to eq "I have the following items for sale:\n+-----------------------------+\na klondike bar                                   price: 10 nerdcoin\na pair of 6-sided dice carved from dragonbone    price: 150 nerdcoin\n\n"
    end
  end

end
