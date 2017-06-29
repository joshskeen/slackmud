FactoryGirl.define do
  factory :effect do
    name Effect::EFFECT_FLYING

    factory :effect_glowing do
      name Effect::EFFECT_GLOWING
    end

    factory :effect_pulsating do
      name Effect::EFFECT_PULSATING
    end

    factory :effect_poisoned do
      name Effect::EFFECT_POISONED
    end
  end
end
