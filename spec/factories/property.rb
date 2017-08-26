FactoryGirl.define do
  factory :property do
    factory :wearable_torso do
      name "wearable"
      value "torso"
    end
    factory :edible_food do
      name "edible"
      value "food"
    end
    factory :edible_drink do
      name "edible"
      value "drink"
    end
    factory :wearable_head do
      name "wearable"
      value "head"
    end
    factory :wearable_hands do
      name "wearable"
      value "hands"
    end
    factory :wearable_neck do
      name "wearable"
      value "neck"
    end
    factory :rollable_d12 do
      name "rollable"
      value "12"
    end
    factory :rollable_d16 do
      name "rollable"
      value "16"
    end
  end
end
