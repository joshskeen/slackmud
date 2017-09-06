
require 'rails_helper'

describe 'Nerdcoin' do

  let(:game){ double(Game) }
  let(:game_command){ GameCommand.new(game) }
  let(:slack_request){ double(SlackRequest) }
  let(:slack_messenger){double(SlackMessenger)}

  describe 'give command' do
    before(:each){
      allow(game).to receive(:slack_request).and_return(slack_request)
      allow(game).to receive(:player).and_return(player)
      allow(game).to receive(:room).and_return(room)
      allow(game).to receive(:slack_messenger).and_return(slack_messenger)
    }

    let(:player){ FactoryGirl.create(:player_with_inventory)}
    let(:joe){FactoryGirl.create(:player_joe)}
    let(:room){ FactoryGirl.create(:room, players: [player, joe])}
    it 'give a single nerdcoin' do
      expect(slack_messenger).to receive(:msg_room).with(room.slackid,"josh skeen gives 1 nerdcoin to joe blow. :moneybag:")
      allow(slack_request).to receive(:text).and_return("give nerdcoin joe")
      expect(game_command.perform).to eq I18n.t('game.give_command.coin_success', target: joe.name, qty: 1)
      joe.reload
      player.reload
      expect(joe.nerdcoins).to eq 1
      expect(player.nerdcoins).to eq 9
    end
    it 'fails giving money a player doesnt have' do
      allow(slack_request).to receive(:text).and_return("give 100 nerdcoin joe")
      expect(game_command.perform).to eq I18n.t('game.insufficient_funds')
      joe.reload
      player.reload
      expect(joe.nerdcoins).to eq 0
      expect(player.nerdcoins).to eq 10
    end
    it 'give a quantity of nerdcoin' do
      expect(slack_messenger).to receive(:msg_room).with(room.slackid,"josh skeen gives 9 nerdcoin to joe blow. :moneybag:")
      allow(slack_request).to receive(:text).and_return("give 9 nerdcoin joe")
      expect(game_command.perform).to eq I18n.t('game.give_command.coin_success', target: joe.name, qty: 9)
      joe.reload
      player.reload
      expect(joe.nerdcoins).to eq 9
      expect(player.nerdcoins).to eq 1
    end
  end
end
