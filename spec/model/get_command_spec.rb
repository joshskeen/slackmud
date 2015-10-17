require 'rails_helper'

describe Command::GetCommand do
  include_context 'game state'
  describe 'success' do
    let(:lootroom) do
      FactoryGirl.create(:room, players: [joe],
                                inventory: inventory_two)
    end

    before(:each) do
      allow(game).to receive(:room).and_return(lootroom)
    end

    it 'error cases' do
      allow(slack_request).to receive(:text).and_return('get pimpcane')
      expect(game_command.perform).to eq I18n.t 'game.get_command.no_item_matching'
      allow(slack_request).to receive(:text).and_return('get 3 loaf')
      expect(game_command.perform).to eq I18n.t 'game.get_command.no_quantity_found'
    end

    it 'success' do
      allow(slack_request).to receive(:text).and_return('get chessboard')
      expect(slack_messenger).to receive(:msg_room).with(room.slackid, 'josh skeen picks up a chessboard soaked in blood.')
      expect(game_command.perform).to eq I18n.t 'game.get_command.success',
        shortdesc: 'a chessboard soaked in blood'
      expect(player.item('fedora').present?).to eq true
      room.reload
      expect(game_command.perform).to eq "I don't see one of those to pick up!"
    end
  end
end
