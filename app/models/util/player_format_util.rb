module PlayerFormatUtil

  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods

    def player_equipment_description
      I18n.t 'game.player_equipment_description', 
        head: equipment_display[Property::WEARABLE_VALUE_HEAD],
        neck: equipment_display[Property::WEARABLE_VALUE_NECK],
        torso: equipment_display[Property::WEARABLE_VALUE_TORSO],
        arms: equipment_display[Property::WEARABLE_VALUE_ARMS],
        hands: equipment_display[Property::WEARABLE_VALUE_HANDS],
        finger: equipment_display[Property::WEARABLE_VALUE_FINGER],
        wrists: equipment_display[Property::WEARABLE_VALUE_WRISTS],
        legs: equipment_display[Property::WEARABLE_VALUE_LEGS],
        feet: equipment_display[Property::WEARABLE_VALUE_FEET]
    end

    def player_details
      I18n.t 'game.player_formatted_details', 
        gender: gender, 
        age: "young",
        alignment: "good" 
    end

    def occupied_equipment_slots 
      inventory
        .wearable_items
        .map{|x| x.wearable.value }
    end

    def equipment_display
      worn_map = build_worn_items_map
      hash_vals = Property::BODY_PARTS.map {|x|
        [x, worn_map.has_key?(x) ? worn_map[x].shortdesc : "nothing"]}
      Hash[hash_vals]
    end

    def build_worn_items_map
      Hash[inventory
        .worn
        .wearable
        .map{|x| [x.wearable.value, x] }]
        .with_indifferent_access
    end

  end

end
