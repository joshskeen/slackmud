require 'rails_helper'

describe 'Get Command' do

  let(:game){ double(Game) }
  let(:game_command){ GameCommand.new(game) }
  let(:slack_request){ double(SlackRequest) }
  let(:slack_messenger){double(SlackMessenger)}

  describe 'success' do
    let(:joe){FactoryGirl.create(:player_joe)}
    let(:item){FactoryGirl.create(:item)}
    let(:inventory){FactoryGirl.create(:inventory_with_items)}
    let(:room){ FactoryGirl.create(:room, players: [joe], 
                                   inventory: inventory)}

    before(:each){
      allow(game).to receive(:slack_request).and_return(slack_request)
      allow(game).to receive(:player).and_return(joe)
      allow(game).to receive(:room).and_return(room)
      allow(game).to receive(:slack_messenger).and_return(slack_messenger)
    }
    it 'error cases' do
      allow(slack_request).to receive(:text).and_return("get pimpcane")
      expect(game_command.perform).to eq I18n.t 'game.get_command.no_item_matching'
      allow(slack_request).to receive(:text).and_return("get 3 loaf")
      expect(game_command.perform).to eq I18n.t 'game.get_command.no_quantity_found'
    end

    it 'success' do
      allow(slack_request).to receive(:text).and_return("get fedora")
      expect(slack_messenger).to receive(:msg_room).with(room.slackid,"joe blow picks up a fedora made of pure crystal.")
      expect(game_command.perform).to eq I18n.t 'game.get_command.success',
        shortdesc: "a fedora made of pure crystal"
      expect(joe.item("fedora").present?).to eq true
      room.reload
      expect(game_command.perform).to eq "I don't see one of those to pick up!"
    end
  end
end
