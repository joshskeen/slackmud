require 'rails_helper'

describe InventoryCommand do

  let(:game){ double(Game) }
  let(:game_command){ GameCommand.new(game) }
  let(:slack_request){ double(SlackRequest) }
  let(:slack_messenger){double(SlackMessenger)}

  let(:josh){ FactoryGirl.create(:player_with_inventory)}
  let(:aleck){ FactoryGirl.create(:player_aleck)}

  before(:each){
    allow(game).to receive(:slack_request).and_return(slack_request)
  }

  describe 'inventory_display' do
    it "shows a list of items possessed" do
      allow(game).to receive(:player).and_return(josh)
      allow(slack_request).to receive(:text).and_return("inventory")
      expect(game_command.perform).to eq "nerdcoins: 10\n\n--------[items]--------\na black woolen tunic\na red apple\na loaf of bread (2)\na cloak made from dryad skin\na purple wizardhat\na fedora made of pure crystal\na pair of 6-sided dice carved from dragonbone\n\n"
    end
    it "shows nothing" do
      allow(game).to receive(:player).and_return(aleck)
      allow(slack_request).to receive(:text).and_return("inventory")
      expect(game_command.perform).to eq "nerdcoins: 0\n\n--------[items]--------\nNothing.\n"
    end
  end

end
