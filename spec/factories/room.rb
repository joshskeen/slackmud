FactoryGirl.define do
  factory :room do
      title "test room"
      slackid "C03RCDX1A"
      description "a room with a test description"
      inventory {FactoryGirl.create(:inventory)}
      factory :room_with_loot do
        title "test room"
        slackid "C03RCDX1A"
        description "a room with a test description"
        inventory {FactoryGirl.create(:inventory_with_loot)}
      end
  end
end
