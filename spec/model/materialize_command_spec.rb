require 'rails_helper'

describe MaterializeCommand do

  let(:game){ double(Game) }
  let(:game_command){ GameCommand.new(game) }
  let(:room){ FactoryGirl.create(:room) }
  let(:slack_request){ double(SlackRequest) }
  let(:slack_messenger){double(SlackMessenger)}

  let(:inventory){FactoryGirl.create(:inventory_with_items)}

  before(:each){
    allow(game).to receive(:slack_request).and_return(slack_request)
    allow(game).to receive(:room).and_return(room)
    allow(game).to receive(:slack_messenger).and_return(slack_messenger)
  }

  describe 'immortal player' do

    let(:player){
      FactoryGirl.create(:immortal, inventory: inventory)
    }
    before(:each){
      allow(game).to receive(:player).and_return(player)
    }

    it "allowed to materialize" do
      allow(slack_request).to receive(:text).and_return("materialize fedora")
      expect(game_command.perform).to eq "You feel your backback grow heavier!"
      allow(slack_request).to receive(:text).and_return("materialize obama")
      expect(game_command.perform).to eq "You can't materialize one of those!"
    end

  end
  describe 'mortal player' do

    let(:player){
      FactoryGirl.create(:player_joe, inventory: inventory)
    }
    before(:each){
      allow(game).to receive(:player).and_return(player)
    }

    it "disallowed from materializing" do
      allow(slack_request).to receive(:text).and_return("materialize fedora")
      expect(game_command.perform).to eq "You must be immortal to do that!"
    end

  end
end
