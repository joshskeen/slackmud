require 'rails_helper'

describe LookCommand do

  let(:game){ double(Game) }
  let(:game_command){ GameCommand.new(game) }
  let(:slack_request){ double(SlackRequest) }
  let(:slack_messenger){double(SlackMessenger)}

  let(:player){ FactoryGirl.create(:player_with_inventory)}
  let!(:aleck){ FactoryGirl.create(:player_aleck)}
  let(:joe){ FactoryGirl.create(:player_joe)}
  let(:loincloth){FactoryGirl.create(:item_loincloth)}
  let(:room_inventory){ FactoryGirl.create(:inventory, items: [loincloth], nerdcoins: 10) }
  let(:room){ FactoryGirl.create(:room, players: [player, joe],
                                 inventory: room_inventory)}

  let(:empty_room){ FactoryGirl.create(:room,
                                       slackid: 'C03RCDX1B',
                                       inventory: Inventory.create(nerdcoins: 10))}

  before(:each){
    allow(game).to receive(:slack_request).and_return(slack_request)
    allow(game).to receive(:player).and_return(player)
    allow(game).to receive(:slack_messenger).and_return(slack_messenger)
    allow(game).to receive(:room).and_return(room)
  }

  it "errors" do
    allow(slack_request).to receive(:text).and_return("look pimpcane")
    expect(game_command.perform).to eq I18n.t 'game.look_command.not_found'
    allow(slack_request).to receive(:text).and_return("look blazing ball of fury")
    expect(game_command.perform).to eq I18n.t 'game.look_command.not_found'
    allow(slack_request).to receive(:text).and_return("look aleck")
    expect(game_command.perform).to eq I18n.t 'game.look_command.not_found'
  end

  it "empty room" do
    allow(game).to receive(:room).and_return(empty_room)
    allow(slack_request).to receive(:text).and_return("look")
    expect(slack_messenger).to receive(:msg_room).with(empty_room.slackid, "josh skeen looks around.")
    expect(game_command.perform).to eq I18n.t 'game.look_command.success',
      objectname: "the room",
      description: empty_room.formatted_description

  end

  it "looks at a room" do
    allow(slack_request).to receive(:text).and_return("look")
    expect(slack_messenger).to receive(:msg_room).with(room.slackid, "josh skeen looks around.")
    expect(game_command.perform).to eq I18n.t 'game.look_command.success',
      objectname: "the room",
      description: room.formatted_description
  end

  it "looks at a room item" do
    allow(slack_request).to receive(:text).and_return("look loincloth")
    expect(slack_messenger).to receive(:msg_room).with(room.slackid, "josh skeen looks at a black leather loincloth.")
    expect(game_command.perform).to eq I18n.t 'game.look_command.success',
      description: loincloth.longdesc,
      objectname: loincloth.shortdesc

  end

  it "looks at an inventory item" do
    allow(slack_request).to receive(:text).and_return("look tunic")
    expect(slack_messenger).to receive(:msg_room).with(room.slackid, "josh skeen looks at a black woolen tunic.")
    expect(game_command.perform).to eq I18n.t 'game.look_command.success',
      description: "you see a black wool tunic neatly folded..",
      objectname: "a black woolen tunic"
  end

  it "looks at player" do
    allow(slack_request).to receive(:text).and_return("look joe")
    expect(slack_messenger).to receive(:msg_room).with(room.slackid, "josh skeen looks at joe blow.")
    expect(game_command.perform).to eq I18n.t 'game.look_command.success',
      description: joe.formatted_description,
      objectname: joe.name
  end

  it "looks at self" do
    allow(slack_request).to receive(:text).and_return("look josh")
    expect(slack_messenger).to receive(:msg_room).with(room.slackid, "josh skeen looks at himself.")
    expect(game_command.perform).to include "You look at yourself. \nits you!"
  end

end
