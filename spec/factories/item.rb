FactoryGirl.define do
  factory :item do
    name "obsidian dagger"
    value 25
    shortdesc "an obsidian dagger"
    longdesc "you see a finely crafted obsidian dagger lying here."

    factory :item_tunic do
      value 15 
      name "black tunic"
      shortdesc "a black woolen tunic"
      longdesc "you see a black wool tunic neatly folded.."
    end

    factory :item_cloak do
      value 15 
      name "druid cloak"
      shortdesc "a cloak made from dryad skin"
      longdesc "a cloak made from dryad skin lies crumpled on the ground here."
      properties {
        [
          FactoryGirl.create(:wearable_neck)
        ]
      }
    end

    factory :item_bloody_chessboard do
      value 10
      name "bloody chessboard"
      shortdesc "a chessboard soaked in blood"
      longdesc "a chessboard clearly involved in a violent crime lies before you! "
      properties {
        [
          FactoryGirl.create(:wearable_hands)
        ]
      }
    end
    factory :item_klondike do
      value 10
      name "klondike bar"
      shortdesc "a klondike bar"
      longdesc "a delicious klondike bar in its original wrapper is ready to be consumed! "
      properties {
        [
          FactoryGirl.create(:edible_food)
        ]
      }
    end


    factory :item_steel_dice do
      value 100
      name "steel dice"
      shortdesc "a large 16-sided steel die"
      longdesc "a large 16-sided die forged from dwarven steel rests here, waiting to be gambled with!"
      properties {
        [
          FactoryGirl.create(:rollable_d16),
          FactoryGirl.create(:wearable_hands)
        ]
      }
    end

    factory :item_minitel_console do

      value 1500
      name "minitel console"
      shortdesc "a minitel console :fax:"
      longdesc "a minitel console lies here, ready to connect you to an electronic world of bits and bytes."
      properties {
        [
          FactoryGirl.create(:wearable_hands)
        ]
      }
    end
    factory :item_dragonbone_dice do

      value 150
      name "dragonbone dice"
      shortdesc "a pair of 6-sided dice carved from dragonbone"
      longdesc "a pair of 6-sided dice carved from dragonbone lies here, waiting to be gambled with!"
      properties {
        [
          FactoryGirl.create(:rollable_d12),
          FactoryGirl.create(:wearable_hands)
        ]
      }
    end

    factory :item_sweetwater do
      value 25
      name "sweetwater 420"
      shortdesc "a sweetwater 420 IPA :beer:"
      longdesc "an ice cold sweetwater 420 ipa! "
      properties {
        [
          FactoryGirl.create(:edible_drink)
        ]
      }
    end
    factory :item_magichat do
      value 35
      name "magichat #9"
      shortdesc "a magichat #9 :beer:"
      longdesc "an ice cold magichat #9 beer longs to be consumed! "
      properties {
        [
          FactoryGirl.create(:edible_drink),
          FactoryGirl.create(:wearable_hands)
        ]
      }
    end
    factory :item_sculpin do
      value 45
      name "sculpin ipa"
      shortdesc "a sculpin grapefruit IPA :beer:"
      longdesc "an ice cold sculin grapefruit :beer: lies here, ready to drink! "
      properties {
        [
          FactoryGirl.create(:edible_drink)
        ]
      }
    end
    factory :item_fedora do
      value 105
      name "crystal fedora"
      shortdesc "a fedora made of pure crystal"
      longdesc "a stylish fedora hewn from one solid piece of crystal sits here!"
      properties {
        [
          FactoryGirl.create(:wearable_head)
        ]
      }
    end
    factory :item_wizardhat do
      value 125
      name "purple wizardhat"
      shortdesc "a purple wizardhat"
      longdesc "a purple wizard hat made from an ancient cloth, radiates a faint glow. "
      properties {
        [
          FactoryGirl.create(:wearable_head)
        ]
      }
    end

    factory :item_loincloth do
      value 150
      name "leather loincloth"
      shortdesc "a black leather loincloth"
      longdesc "you see a black leather loincloth lying on the ground"
      properties {
        [
          FactoryGirl.create(:wearable_torso)
        ]
      }
    end

    factory :item_apple do
      value 5
      name "apple"
      shortdesc "a red apple"
      longdesc "a delicious looking red apple lies here ready to be eaten."
      properties {
        [
          FactoryGirl.create(:edible_food)
        ]
      }
    end

    factory :item_birthday_cake do
      value 25
      name "slice of birthday cake"
      shortdesc "a slice of birthday cake"
      longdesc "a neatly cut slice of birthday cake lies here with a single lit candle on top of it."
      properties {
        [
          FactoryGirl.create(:edible_food)
        ]
      }
    end
    factory :item_loaf do
      value 10
      name "loaf of bread"
      shortdesc "a loaf of bread"
      longdesc "a freshly baked loaf of bread looks good enough to eat!"
      properties {
        [
          FactoryGirl.create(:edible_food)
        ]
      }
    end

  end

end
