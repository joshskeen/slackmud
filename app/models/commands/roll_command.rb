class RollCommand < GameCommandBase
  include PlayerUtil

  def perform
    return I18n.t 'game.roll_command.no_rollable' if !wearing_rollable?
    slack_messenger.msg_room(room.slackid, room_message)
    I18n.t 'game.roll_command.success', dicename: dice.shortdesc, score: calculate_roll
  end

  private

  def room_message
    I18n.t 'game.roll_command.slack_success',
      dicename: dice.shortdesc,
      name: player.name,
      gender: player.third_person_subject.capitalize,
      score: calculate_roll
  end

  def wearing_rollable?
    player.inventory.worn.rollable.count > 0
  end

  def dice
    player.inventory.worn.rollable.first
  end

  def dice_value
    dice.properties.where("properties.name = 'rollable'").first.value.to_i
  end

  def calculate_roll
    @roll ||= (1..dice_value).to_a.sample
  end

  def remove_item
    inventory_item = player.inventory.inventory_items.where(item_id: item, worn: true).first
    inventory_item.worn = false
    inventory_item.save
  end

  def slot_occupied?
    occupied_slots.include? wearable_slot
  end

end
