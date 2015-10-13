# == Schema Information
#
# Table name: properties
#
#  id    :integer          not null, primary key
#  value :string
#

class Property < ActiveRecord::Base

  NAME_WEARABLE = "wearable".freeze

  WEARABLE_VALUE_HEAD = "head".freeze
  WEARABLE_VALUE_NECK = "neck".freeze
  WEARABLE_VALUE_TORSO = "torso".freeze
  WEARABLE_VALUE_ARMS = "arms".freeze
  WEARABLE_VALUE_HANDS = "hands".freeze
  WEARABLE_VALUE_FINGER = "finger".freeze
  WEARABLE_VALUE_WRISTS = "wrists".freeze
  WEARABLE_VALUE_LEGS = "legs".freeze
  WEARABLE_VALUE_FEET = "feet".freeze

  BODY_PARTS = [
    WEARABLE_VALUE_HEAD, 
    WEARABLE_VALUE_NECK, 
    WEARABLE_VALUE_TORSO,
    WEARABLE_VALUE_ARMS, 
    WEARABLE_VALUE_HANDS, 
    WEARABLE_VALUE_FINGER, 
    WEARABLE_VALUE_WRISTS, 
    WEARABLE_VALUE_LEGS, 
    WEARABLE_VALUE_FEET
  ].freeze
end
