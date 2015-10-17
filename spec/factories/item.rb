FactoryGirl.define do
  factory :item do
    name 'obsidian dagger'
    shortdesc 'an obsidian dagger'
    longdesc 'you see a finely crafted obsidian dagger lying here.'

    factory :item_tunic do
      name 'black tunic'
      shortdesc 'a black woolen tunic'
      longdesc 'you see a black wool tunic neatly folded..'
    end

    factory :item_cloak do
      name 'druid cloak'
      shortdesc 'cloak made from dryad skin'
      longdesc 'a cloak made from dryad skin lies crumpled on the ground here.'
      properties do
        [
          FactoryGirl.create(:wearable_neck)
        ]
      end
    end

    factory :item_chessboard do
      name 'bloody chessboard'
      shortdesc 'a chessboard soaked in blood'
      longdesc 'a chessboard clearly involved in a violent crime lies before you! '
      properties do
        [
          FactoryGirl.create(:wearable_hands)
        ]
      end
    end
    factory :item_klondike do
      name 'klondike bar'
      shortdesc 'a klondike bar'
      longdesc 'a delicious klondike bar in its original wrapper is ready to be consumed! '
      properties do
        [
          FactoryGirl.create(:edible_food)
        ]
      end
    end

    factory :item_sweetwater do
      name 'sweetwater 420'
      shortdesc 'a sweetwater 420 IPA :beer:'
      longdesc 'an ice cold sweetwater 420 ipa! '
      properties do
        [
          FactoryGirl.create(:edible_drink)
        ]
      end
    end
    factory :item_magichat do
      name 'magichat #9'
      shortdesc 'a magichat #9 :beer:'
      longdesc 'an ice cold magichat #9 beer longs to be consumed! '
      properties do
        [
          FactoryGirl.create(:edible_drink),
          FactoryGirl.create(:wearable_hands)
        ]
      end
    end
    factory :item_sculpin do
      name 'sculpin ipa'
      shortdesc 'a sculpin grapefruit IPA :beer:'
      longdesc 'an ice cold sculin grapefruit :beer: lies here, ready to drink! '
      properties do
        [
          FactoryGirl.create(:edible_drink)
        ]
      end
    end
    factory :item_fedora do
      name 'crystal fedora'
      shortdesc 'a fedora made of pure crystal'
      longdesc 'a stylish fedora hewn from one solid piece of crystal sits here!'
      properties do
        [
          FactoryGirl.create(:wearable_head)
        ]
      end
    end
    factory :item_wizardhat do
      name 'purple wizardhat'
      shortdesc 'a purple wizardhat'
      longdesc 'a purple wizard hat made from an ancient cloth, radiates a faint glow. '
      properties do
        [
          FactoryGirl.create(:wearable_head)
        ]
      end
    end

    factory :item_loincloth do
      name 'leather loincloth'
      shortdesc 'a black leather loincloth'
      longdesc 'you see a black leather loincloth lying on the ground'
      properties do
        [
          FactoryGirl.create(:wearable_torso)
        ]
      end
    end

    factory :item_loaf do
      name 'loaf of bread'
      shortdesc 'loaf of bread'
      longdesc 'A freshly baked loaf of bread looks good enough to eat!'
      properties do
        [
          FactoryGirl.create(:edible_food)
        ]
      end
    end
  end
end
