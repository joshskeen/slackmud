require 'rails_helper'

describe LookCommand do
  let(:game){ double(Game) }
  let(:game_command){ GameCommand.new(game) }
  let(:slack_request){ double(SlackRequest) }
  let(:slack_messenger){double(SlackMessenger)}

  let(:player){ FactoryGirl.create(:player_with_inventory)}
  let!(:aleck){ FactoryGirl.create(:player_aleck)}
  let(:joe){ FactoryGirl.create(:player_joe)}
  let!(:loincloth){FactoryGirl.create(:item_loincloth)}
  let(:keeper) { FactoryGirl.create(:player_shopkeeper_lars)}
  let(:room_inventory){ FactoryGirl.create(:inventory, items: [loincloth], nerdcoins: 10) }
  let(:room){ FactoryGirl.create(:room, players: [player, joe, keeper],
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

  describe 'looking at a room' do
    it 'shows the expected description, including npcs' do
      allow(slack_request).to receive(:text).and_return("look")
#'game.look_command.success',
      #objectname: "the room",
      #description: empty_room.formatted_description
    expect(slack_messenger).to receive(:msg_room).with(room.slackid, "josh skeen looks around.")
      expect(game_command.perform).to eq "You look at the room. \n\na room with a test description\n\nLars the shopkeeper smiles and patiently waits for you to buy something.\n\nit contains:\n10 nerdcoins \na black leather loincloth\n\n"
    end
  end

end
