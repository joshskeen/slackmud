FactoryGirl.define do
  factory :inventory do
    factory :inventory_with_food do
      items do
        [
          FactoryGirl.create(:item_loaf),
          Item.first_by_keyword('loaf'),
          FactoryGirl.create(:item_klondike),
          FactoryGirl.create(:item_sculpin),
          FactoryGirl.create(:item_fedora)
        ]
      end
    end
    factory :inventory_with_items do
      items do
        [
          FactoryGirl.create(:item_tunic),
          FactoryGirl.create(:item_loaf),
          FactoryGirl.create(:item_cloak),
          FactoryGirl.create(:item_wizardhat),
          FactoryGirl.create(:item_fedora),
          Item.first_by_keyword('loaf')
        ]
      end
    end

    factory :inventory_with_more_items do
      items do
        [
          FactoryGirl.create(:item_chessboard),
          Item.first_by_keyword('loaf')
        ]
      end
    end
  end
end
