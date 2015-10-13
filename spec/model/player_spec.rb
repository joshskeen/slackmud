require 'rails_helper'
describe Player do

  let!(:player){ FactoryGirl.create(:player, 
                                    name: "josh",
                                    description: "You see nothing special about them.",
                                    inventory: inventory,
                                    gender: "male") }
  let(:player_equipment_description){
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
  }
  let!(:items){
    [
      FactoryGirl.create(:item, shortdesc: "a leather girdle", properties: [
        FactoryGirl.create(:property, name: "wearable", value: "torso")
      ]),
      FactoryGirl.create(:item, shortdesc: "a tophat", properties: [
        FactoryGirl.create(:property, name: "wearable", value: "head")
      ]),
      FactoryGirl.create(:item, shortdesc: "a rock")
    ]
  }
  let!(:inventory){FactoryGirl.create(:inventory, items: items)}

  describe "worn clothing" do
    before :each do
      player.inventory.inventory_items.update_all(worn: true)
    end

    it "formatted equipment list" do
      expect(player.player_equipment_description).to eq player_equipment_description
    end

    it "formatted player description" do
      expect(player.formatted_description).to eq I18n.t 'game.player_formatted_description', 
        description: "You see nothing special about them.", 
        details: "gender: male\nage: young\nalignment: good\n",
        equipment: player_equipment_description 
    end

  end

end
