require 'rails_helper'

describe DropCommand do

  let(:slack_request){ double(SlackRequest) }
  let(:game){ double(Game) }
  let(:game_command){ GameCommand.new(game) }
  let(:slack_messenger){double(SlackMessenger)}
  let(:player){ FactoryGirl.create(:player_with_inventory)}
  let(:room){ FactoryGirl.create(:room, players: [player])}

  before(:each){
    allow(game).to receive(:slack_request).and_return(slack_request)
    allow(game).to receive(:player).and_return(player)
    allow(game).to receive(:room).and_return(room)
    allow(game).to receive(:slack_messenger).and_return(slack_messenger)
  }

  it "error cases" do
    allow(slack_request).to receive(:text).and_return("drop pimpcane")
    expect(game_command.perform).to eq "You don't have one of those to drop!"
    allow(slack_request).to receive(:text).and_return("drop 2 tunic")
    expect(game_command.perform).to eq "You don't have that many!"
  end

  it "transfers an item from player to room" do
    allow(slack_request).to receive(:text).and_return("drop tunic")
    expect(slack_messenger).to receive(:msg_room).with(room.slackid, "josh skeen drops a black woolen tunic on the floor. (1)")
    expect(game_command.perform).to eq "Ok, you drop a black woolen tunic. (1)"
  end
end

