require 'rails_helper'

describe EatCommand do

  let(:game){ double(Game) }
  let(:game_command){ GameCommand.new(game) }
  let(:slack_request){ double(SlackRequest) }
  let(:slack_messenger){double(SlackMessenger)}

  let(:player){ FactoryGirl.create(:player_with_food)}
  let(:room){ FactoryGirl.create(:room, players: [player])}

  before(:each){
    allow(game).to receive(:slack_request).and_return(slack_request)
    allow(game).to receive(:player).and_return(player)
    allow(game).to receive(:room).and_return(room)
    allow(game).to receive(:slack_messenger).and_return(slack_messenger)
  }
  describe 'error' do
    it 'error cases' do
      allow(slack_request).to receive(:text).and_return("eat turkey")
      expect(game_command.perform).to eq I18n.t 'game.eat_command.no_item_matching'
      allow(slack_request).to receive(:text).and_return("eat fedora")
      expect(game_command.perform).to eq I18n.t 'game.eat_command.inedible'
    end
    describe 'success' do
      it 'eats a single item' do
        allow(slack_request).to receive(:text).and_return("eat loaf")
        expect(slack_messenger).to receive(:msg_room).with(room.slackid, "josh skeen eats a loaf of bread. Delicious!")
        expect(game_command.perform).to eq I18n.t('game.eat_command.success', shortdesc: "a loaf of bread", actiontype: "eat")
        player.reload
        expect(player.inventory.items.by_keyword("loaf").count).to eq 1
      end
      it 'drinks a single item' do
        allow(slack_request).to receive(:text).and_return("drink sculpin")
        expect(slack_messenger).to receive(:msg_room).with(room.slackid, "josh skeen drinks a sculpin grapefruit IPA :beer:. Delicious!")
        expect(game_command.perform).to eq I18n.t('game.eat_command.success', shortdesc: "a sculpin grapefruit IPA :beer:", actiontype: "drink")
        player.reload
        expect(player.inventory.items.by_keyword("sculpin").count).to eq 0
      end
    end

  end

end
