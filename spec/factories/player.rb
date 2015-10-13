FactoryGirl.define do
  factory :player do

    factory :player_with_food do
      name "josh skeen"
      gender "male"
      description "its you!"
      slackid "U03RCDX0U"
      inventory {FactoryGirl.create(:inventory_with_food)}
    end

    factory :immortal do
      name "josh skeen"
      gender "male"
      description "its you!"
      slackid "U03RCDX0U"
      immortal true
      inventory {FactoryGirl.create(:inventory_with_items)}
    end

    factory :player_with_inventory do
      name "josh skeen"
      gender "male"
      description "its you!"
      slackid "U03RCDX0U"
      inventory {FactoryGirl.create(:inventory_with_items)}
    end

    factory :player_aleck do
      name "aleck"
      gender "female"
      description "Aleck stands here!"
      slackid "FAKE"
      inventory { Inventory.create}
    end
    factory :player_josh do
      name "josh skeen"
      gender "male"
      description "its you!"
      slackid "U03RCDX0U"
      inventory { Inventory.create}
    end
    factory :player_joe do
      name "joe blow"
      gender "male"
      description "its you!"
      slackid "U03S2MZBG"
      inventory { Inventory.create}
    end

  end

end
