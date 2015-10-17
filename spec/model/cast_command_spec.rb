require 'rails_helper'

describe Command::CastCommand do
  include_context 'game state'

  let(:item) { FactoryGirl.create(:item) }

  before(:each) do
    FactoryGirl.create(:item_sculpin)
    FactoryGirl.create(:item_sweetwater)
    FactoryGirl.create(:item_magichat)
  end

  describe 'errors' do
    it 'cast what'do
      allow(slack_request).to receive(:text).and_return('cast')
      expect(game_command.perform).to eq 'Cast what?!'
    end
    it 'not found'do
      allow(slack_request).to receive(:text).and_return('cast create pimpcane')
      expect(game_command.perform).to eq "You don't know that spell!"
    end
  end

  describe Spell::SpellCreateBeer do
    it 'creates beer!' do
      allow(slack_request).to receive(:text).and_return('cast create beer')
      expect(slack_messenger).to receive(:msg_room)
      expect(game_command.perform).to include ''
      room.reload
      expect(room.inventory.items.by_keyword('beer').count).to eq 1
    end
  end
  describe Spell::SpellBless do
    describe 'blesses objects!' do
      it 'bless with no target' do
        allow(slack_request).to receive(:text).and_return('cast bless bigdaddy')
        expect(game_command.perform).to include "I don't see that here!"
        allow(slack_request).to receive(:text).and_return('cast bless joe')
      end
      it 'bless with target' do
        allow(slack_request).to receive(:text).and_return('cast bless randy')
        expect(game_command.perform).to include "I don't see that here!"
      end
    end
  end
end
