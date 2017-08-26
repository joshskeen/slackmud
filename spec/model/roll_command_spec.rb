require 'rails_helper'

describe RollCommand do

  let(:game){ double(Game) }
  let(:game_command){ GameCommand.new(game) }
  let(:slack_request){ double(SlackRequest) }
  let(:slack_messenger){double(SlackMessenger)}

  let(:player){ FactoryGirl.create(:player_with_inventory)}
  let(:room){ FactoryGirl.create(:room, players: [player])}

  before(:each){
    allow_any_instance_of(RollCommand).to receive(:calculate_roll).and_return(1)
    allow_any_instance_of(RollCommand).to receive(:dice_value).and_return(12)
    allow(game).to receive(:slack_request).and_return(slack_request)
    allow(game).to receive(:player).and_return(player)
    allow(game).to receive(:room).and_return(room)
    allow(game).to receive(:slack_messenger).and_return(slack_messenger)
  }
    describe 'success' do
      it 'rolls the dice!' do
        player.inventory.inventory_items.where(item_id: player.inventory.items.rollable.first).first.update_attribute(:worn, true)
        allow(slack_request).to receive(:text).and_return("roll")
        expect(slack_messenger).to receive(:msg_room).with("C03RCDX1A", "josh skeen rolls a pair of 6-sided dice carved from dragonbone. :game_die: He got a *1* :cry:")
        expect(game_command.perform).to eq "You roll a pair of 6-sided dice carved from dragonbone! You got a 1."
      end
    end
    describe 'failure' do
      it 'cant roll without dice!' do
        allow(slack_request).to receive(:text).and_return("roll")
        expect(game_command.perform).to eq 'You need to hold some dice first!'
      end
    end
end
