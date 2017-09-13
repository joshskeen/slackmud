
require 'rails_helper'

describe ListCommand do

  let(:game){ double(Game) }
  let(:game_command){ GameCommand.new(game) }
  let(:slack_request){ double(SlackRequest) }
  let(:slack_messenger){double(SlackMessenger)}
  let!(:cake){FactoryGirl.create(:item_birthday_cake)}

  let(:josh){ FactoryGirl.create(:player_with_inventory)}
  let(:shopkeeper){ FactoryGirl.create(:player_shopkeeper)}

  let(:room){ FactoryGirl.create(:room, players: [josh, shopkeeper])}
  before(:each){
    allow(game).to receive(:slack_request).and_return(slack_request)
    allow(game).to receive(:player).and_return(josh)
    allow(game).to receive(:room).and_return(room)
  }

  describe 'with a single shopkeeper present' do
    it "shows a list of items for purchase" do
      allow(slack_request).to receive(:text).and_return("list")
      expect(game_command.perform).to eq ""
    end
  end

end
