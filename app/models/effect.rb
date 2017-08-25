class Effect < ActiveRecord::Base
  EFFECT_FLYING = "flying"
  EFFECT_GLOWING = "glowing"
  EFFECT_PULSATING = "pulsating"
  EFFECT_POISONED = "poisoned"
  EFFECT_INVIZED = "invized"

  PLAYER_EFFECT = {
    Effect::EFFECT_FLYING => "They are flying in the air!!"
  }
end
