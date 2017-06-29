require 'rails_helper'
describe Player do
  let!(:player) do
    FactoryGirl.create(:player,
                       name: 'josh',
                       description: 'You see nothing special about them.',
                       inventory: inventory,
                       gender: 'male')
  end
  let!(:effected_player) { FactoryGirl.create(:player_with_effect) }
  let(:player_equipment_description) do
    "---equipment---
worn on head: a tophat
worn aroud neck: nothing
worn on torso: a leather girdle
worn on arms: nothing
worn on hands: nothing
worn on finger: nothing
worn on wrists: nothing
worn on legs: nothing
worn on feet: nothing
"
  end
  let!(:items) do
    [
      FactoryGirl.create(:item, shortdesc: 'a leather girdle', properties: [
        FactoryGirl.create(:property, name: 'wearable', value: 'torso')
      ]),
      FactoryGirl.create(:item, shortdesc: 'a tophat', properties: [
        FactoryGirl.create(:property, name: 'wearable', value: 'head')
      ]),
      FactoryGirl.create(:item, shortdesc: 'a rock')
    ]
  end
  let!(:inventory) { FactoryGirl.create(:inventory, items: items) }

  describe 'worn clothing' do
    before :each do
      player.inventory.inventory_items.update_all(worn: true)
    end

    it 'formatted equipment list' do
      expect(player.player_equipment_description).to eq player_equipment_description
    end

    it 'effected player ' do
      expect(effected_player.formatted_description).to eq "low and behold!\n---effected by---\nThey are flying in the air!!\n\ngender: male\nage: young\nalignment: good\n\n---equipment---\nworn on head: nothing\nworn aroud neck: nothing\nworn on torso: nothing\nworn on arms: nothing\nworn on hands: nothing\nworn on finger: nothing\nworn on wrists: nothing\nworn on legs: nothing\nworn on feet: nothing\n\n"
    end

    it 'formatted player description' do
      expect(player.formatted_description).to eq I18n.t 'game.player_formatted_description',
                                                        description: 'You see nothing special about them.',
                                                        details: "gender: male\nage: young\nalignment: good\n",
                                                        effects: "---effected by---\nnone.\n",
                                                        equipment: player_equipment_description
    end
  end
end
