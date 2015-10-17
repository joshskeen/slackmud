require 'rails_helper'

describe 'Give Command' do

  include_context 'game state'
  
  describe 'error' do
    let(:player) { FactoryGirl.create(:player_with_inventory) }
    let(:joe) { FactoryGirl.create(:player_joe) }
    let(:item) { FactoryGirl.create(:item) }
    let(:room) { FactoryGirl.create(:room, players: [player, joe]) }

    before(:each) do
      allow(game).to receive(:slack_request).and_return(slack_request)
      allow(game).to receive(:player).and_return(player)
      allow(game).to receive(:room).and_return(room)
    end
    it 'error cases' do
      allow(slack_request).to receive(:text).and_return('give pimpcane jesus')
      expect(game_command.perform).to eq I18n.t 'game.give_command.no_item_matching'
      allow(slack_request).to receive(:text).and_return('give tunic')
      expect(game_command.perform).to eq I18n.t 'game.give_command.no_target'
      allow(slack_request).to receive(:text).and_return('give tunic arnold')
      expect(game_command.perform).to eq I18n.t 'game.give_command.target_not_found'
      allow(slack_request).to receive(:text).and_return('give 2 tunic joe')
      expect(game_command.perform).to eq I18n.t('game.give_command.quantity_not_found', item: Item.first_by_keyword('tunic'), target: joe)
    end
  end
  describe 'success' do
    before(:each) do
      allow(game).to receive(:slack_request).and_return(slack_request)
      allow(game).to receive(:player).and_return(player)
      allow(game).to receive(:room).and_return(room)
      allow(game).to receive(:slack_messenger).and_return(slack_messenger)
    end

    let(:player) { FactoryGirl.create(:player_with_inventory) }
    let(:joe) { FactoryGirl.create(:player_joe) }
    let(:room) { FactoryGirl.create(:room, players: [player, joe]) }
    let(:item) do
      Item.first_by_keyword('loaf')
    end
    it 'give a single item' do
      expect(slack_messenger).to receive(:msg_room).with(room.slackid, 'josh skeen gives loaf of bread to joe blow.')
      allow(slack_request).to receive(:text).and_return('give loaf joe')
      expect(game_command.perform).to eq I18n.t('game.give_command.success', itemdesc: item.shortdesc, target: joe.name, qty: 1)
      expect(joe.possesses?(item, 1)).to eq true
      expect(player.possesses?(item, 1)).to eq true
    end

    it 'give multiple items' do
      expect(slack_messenger).to receive(:msg_room).with(room.slackid, 'josh skeen gives loaf of bread to joe blow.')
      allow(slack_request).to receive(:text).and_return('give 2 loaf joe')
      expect(game_command.perform).to eq I18n.t('game.give_command.success', itemdesc: item.name, target: joe.name, qty: 2)
      expect(joe.possesses?(item, 2)).to eq true
      expect(player.possesses?(item, 0)).to eq true
    end
  end
end
