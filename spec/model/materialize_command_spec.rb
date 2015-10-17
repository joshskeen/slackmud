require 'rails_helper'

describe Command::MaterializeCommand do
  include_context 'game state'

  describe 'immortal player' do
    let(:player) do
      FactoryGirl.create(:immortal, inventory: inventory)
    end
    before(:each) do
      allow(game).to receive(:player).and_return(player)
    end

    it 'allowed to materialize' do
      allow(slack_request).to receive(:text).and_return('materialize fedora')
      expect(game_command.perform).to eq 'You feel your backback grow heavier!'
      allow(slack_request).to receive(:text).and_return('materialize obama')
      expect(game_command.perform).to eq "You can't materialize one of those!"
    end
  end
  describe 'mortal player' do
    let(:player) do
      FactoryGirl.create(:player_joe, inventory: inventory)
    end
    before(:each) do
      allow(game).to receive(:player).and_return(player)
    end

    it 'disallowed from materializing' do
      allow(slack_request).to receive(:text).and_return('materialize fedora')
      expect(game_command.perform).to eq 'You must be immortal to do that!'
    end
  end
end
