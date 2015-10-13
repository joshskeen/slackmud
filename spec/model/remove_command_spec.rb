require 'rails_helper'

describe RemoveCommand do

  let(:game){ double(Game) }
  let(:game_command){ GameCommand.new(game) }
  let(:slack_request){ double(SlackRequest) }
  let(:slack_messenger){double(SlackMessenger)}

  let(:room){ FactoryGirl.create(:room)}

  before(:each){
    allow(game).to receive(:slack_request).and_return(slack_request)
    allow(game).to receive(:room).and_return(room)
  }

  describe "success" do
    let(:player){ FactoryGirl.create(:player_with_inventory)}
    before(:each){
      allow(game).to receive(:player).and_return(player)
      allow(game).to receive(:slack_messenger).and_return(slack_messenger)
      item = player.inventory.items.by_keyword("fedora").first
      inventory_item = player.inventory.inventory_items.where(item_id: item).first
      inventory_item.worn = true
      inventory_item.save
      player.reload
    }

    it "disallows removing an unworn item" do
      allow(slack_request).to receive(:text).and_return("remove tunic")
      expect(game_command.perform).to eq "You aren't wearing one of those!"
    end

    it "removes a worn item" do
      expect(slack_messenger).to receive(:msg_room).with(room.slackid, "josh skeen stops wearing a fedora made of pure crystal.")
      allow(slack_request).to receive(:text).and_return("remove fedora")
      expect(game_command.perform).to eq "You stop wearing a fedora made of pure crystal."
    end

  end
end
