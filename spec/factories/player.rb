FactoryGirl.define do
  factory :player do

    factory :player_with_effect do
      name "johnny feelgood"
      gender "male"
      description "low and behold!"
      slackid "U03RCDX0U"
      inventory {FactoryGirl.create(:inventory_with_food)}
      effects {
        [
          FactoryGirl.create(:effect_flying)
        ]
      }
    end
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
    factory :player_invized_bob do
      name "donny average"
      gender "male"
      description "its you!"
      slackid "U03S2MZBH"
      inventory { Inventory.create}
      effects {
        [
          FactoryGirl.create(:effect_invized)
        ]
      }
    end
    factory :player_joe do
      name "joe blow"
      gender "male"
      description "its you!"
      slackid "U03S2MZBG"
      inventory { Inventory.create}
    end

    factory :player_shopkeeper do
      gender "male"
      name "the Shopkeeper"
      shortdesc "The shopkeeper smiles and patiently waits for you to buy something."
      description "The shopkeeper will fight like a madman to protect his store from riff-raff
like you."
      npc true
      shopkeeper true
      inventory {
        Inventory.create(items: [Item.first])
      }
    end

  end

end
