require 'rails_helper'

describe CastCommand do
  let(:game) { double(Game) }
  let(:game_command) { GameCommand.new(game) }
  let(:slack_request) { double(SlackRequest) }
  let(:slack_messenger) { double(SlackMessenger) }
  let(:player) { FactoryGirl.create(:player_with_inventory) }
  let(:joe) { FactoryGirl.create(:player_joe) }
  let(:item) { FactoryGirl.create(:item) }
  let(:room) { FactoryGirl.create(:room, players: [player, joe]) }

  before(:each) do
    allow(game).to receive(:slack_request).and_return(slack_request)
    allow(game).to receive(:player).and_return(player)
    allow(game).to receive(:room).and_return(room)
    allow(game).to receive(:slack_messenger).and_return(slack_messenger)
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

  describe SpellCreateBeer do
    it 'creates beer!' do
      allow(slack_request).to receive(:text).and_return('cast create beer')
      expect(slack_messenger).to receive(:msg_room)
      expect(game_command.perform).to include 'You move your hands in an intricate'
      room.reload
      expect(room.inventory.items.by_keyword('beer').count).to eq 1
    end
  end

  describe SpellBless do
    it 'blesses people!' do
      allow(slack_request).to receive(:text).and_return('cast bless joe')
      expect(slack_messenger).to receive(:msg_room)
      expect(game_command.perform).to include 'You begin to utter the names of powerful ancient deities as you prepare to bless joe!'
      expect(SpellBlessWorker).to have_enqueued_job("C03RCDX1A", "A divine light surrounds joe blow in a shimmering white aura. He has been blessed by the ancient gods!")
      expect(SpellBlessWorker).to have_enqueued_job("C03RCDX1A", "The divine light surrounding joe blow fades to normal." )
    end
  end
end
