require 'rails_helper'

describe CastCommand do
  let(:game) { double(Game) }
  let(:game_command) { GameCommand.new(game) }
  let(:slack_request) { double(SlackRequest) }
  let(:slack_messenger) { double(SlackMessenger) }
  let(:player) { FactoryGirl.create(:player_with_inventory, immortal: true) }
  let!(:effect_flying) { FactoryGirl.create(:effect_flying) }
  let!(:effect_invized) { FactoryGirl.create(:effect_invized) }
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

  describe SpellInviz  do
    it 'invizes people!' do
      allow(slack_request).to receive(:text).and_return('cast inviz joe')
      expect(slack_messenger).to receive(:msg_room).with('C03RCDX1A', "josh skeen utters the words 'dissipati peribunt!'. joe fades out of existence.")
      expect(game_command.perform).to include "You feel your will reach into the etheric realm successfully..."
      expect(joe.effects.where(name: Effect::EFFECT_INVIZED).count).to eq 1
      expect(joe.name).to eq "someone"
    end
    it 'doesnt inviz people who are invized' do
      allow(slack_request).to receive(:text).and_return('cast inviz joe')
      joe.effects << Effect.where(name: Effect::EFFECT_INVIZED)
      expect(game_command.perform).to include "They're not here!"
    end
    it 'inviz self' do
      allow(slack_request).to receive(:text).and_return('cast inviz')
      expect(slack_messenger).to receive(:msg_room).with("C03RCDX1A","josh skeen utters the words 'dissipati peribunt!'. josh skeen fades out of existence.")
      expect(game_command.perform).to include "You feel your will reach into the etheric realm successfully..."
      expect(player.effects.where(name: Effect::EFFECT_INVIZED).count).to eq 1
      expect(player.name).to eq "someone"
    end
  end

  describe SpellBless do
    it 'blesses people!' do
      allow(slack_request).to receive(:text).and_return('cast bless joe')
      expect(slack_messenger).to receive(:msg_room)
      expect(game_command.perform).to include 'You begin to utter the names of powerful ancient deities as you prepare to bless joe!'
      expect(SpellWorker).to have_enqueued_job('C03RCDX1A', 'A divine light surrounds joe blow in a shimmering white aura. He has been blessed by the ancient gods!')
      expect(SpellWorker).to have_enqueued_job('C03RCDX1A', 'The divine light surrounding joe blow fades to normal.')
    end
  end


  describe SpellManifest do
    it 'manifests objects!' do
      allow(slack_request).to receive(:text).and_return('cast manifest apple')
      expect(slack_messenger).to receive(:msg_room).with('C03RCDX1A', 'josh skeen points his finger at the ground. In a flash of light, a red apple springs into existence!')
      expect(game_command.perform).to include 'You feel your will reach into the etheric realm successfully...'
    end
  end

  describe SpellLevitate do
    it 'levitates people!' do
      allow(slack_request).to receive(:text).and_return('cast levitate joe')
      expect(slack_messenger).to receive(:msg_room).with('C03RCDX1A', "josh skeen utters the words 'ad patitur te fugere'. joe rises into the air!")
      expect(game_command.perform).to include 'The gods manifest your will that joe take flight!'
      expect(SpellLevitateWorker).to have_enqueued_job('C03RCDX1A', joe.id, "joe blow falls slowly back to the ground.")
    end
  end
end
