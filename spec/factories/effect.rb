FactoryGirl.define do
  factory :effect do

    factory :effect_flying do
      name Effect::EFFECT_FLYING
    end

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
