require 'rails_helper'

describe BuyCommand do

  let(:game){ double(Game) }
  let(:game_command){ GameCommand.new(game) }
  let(:slack_request){ double(SlackRequest) }
  let(:slack_messenger){double(SlackMessenger)}
  let(:josh){ FactoryGirl.create(:player_with_inventory)}
  let(:shopkeeper){ FactoryGirl.create(:player_shopkeeper_lars,
  inventory: Inventory.create(items: [FactoryGirl.create(:item_steel_dice), FactoryGirl.create(:item_bloody_chessboard)]))
  }
let(:room){ FactoryGirl.create(:room, players: [josh, shopkeeper])}
  before(:each){
    allow(game).to receive(:slack_request).and_return(slack_request)
    allow(game).to receive(:slack_messenger).and_return(slack_messenger)
    allow(game).to receive(:player).and_return(josh)
    allow(game).to receive(:room).and_return(room)
  }

  describe 'with a single shopkeeper present' do
    it "with no target says what do you want buy" do
      allow(slack_request).to receive(:text).and_return("buy")
      expect(game_command.perform).to eq "Buy what?"
    end
    it "with no item available says that item isnt available" do
      allow(slack_request).to receive(:text).and_return("buy fedora")
      expect(game_command.perform).to eq "The shopkeeper doesn't have one of those to sell."
    end
    it "with insufficient funds" do
      allow(slack_request).to receive(:text).and_return("buy steel")
      expect(game_command.perform).to eq "You lack the nerdcoin to purchase a large 16-sided steel die."
    end
    it "with sufficient funds" do
      allow(slack_request).to receive(:text).and_return("buy chessboard")
      expect(slack_messenger).to receive(:msg_room).with(room.slackid,"josh skeen purchases a a chessboard soaked in blood from Lars the Shopkeeper for 10 nerdcoin.")
      expect(game_command.perform).to eq "Ok, you purchase the a chessboard soaked in blood from Lars the Shopkeeper for 10 nerdcoin.\n"
      josh.reload
      expect(josh.nerdcoins).to eq 0
      expect(josh.inventory.items.last.name).to eq "bloody chessboard"
    end
  end

end
