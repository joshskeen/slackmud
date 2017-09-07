FactoryGirl.define do
  factory :inventory do
    factory :inventory_with_food do
      items {
        [
          FactoryGirl.create(:item_loaf),
          Item.first_by_keyword("loaf"),
          FactoryGirl.create(:item_klondike), 
          FactoryGirl.create(:item_apple), 
          FactoryGirl.create(:item_sculpin), 
          FactoryGirl.create(:item_fedora), 
        ]
      }
    end
    factory :inventory_with_loot do
      nerdcoins 10
    end
    factory :inventory_with_items do
      items {
        [
          FactoryGirl.create(:item_tunic),
          FactoryGirl.create(:item_apple),
          FactoryGirl.create(:item_loaf),
          FactoryGirl.create(:item_cloak), 
          FactoryGirl.create(:item_wizardhat), 
          FactoryGirl.create(:item_fedora), 
          FactoryGirl.create(:item_dragonbone_dice), 
          Item.first_by_keyword("loaf")
        ]
      }
      nerdcoins 10
    end
  end
end
