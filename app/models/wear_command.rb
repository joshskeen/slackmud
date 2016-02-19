class WearCommand < GameCommandBase
  include PlayerUtil

  def perform
    return I18n.t 'game.wear_command.no_item_matching' if !player_has_item?
    return I18n.t 'game.wear_command.not_wearable' if !item.wearable?
    return I18n.t 'game.wear_command.slot_occupied', slot: item.wearable.value if slot_occupied?
    wear_item
    slack_messenger.msg_room(room.slackid, room_message)
    I18n.t 'game.wear_command.success', itemname: item.shortdesc, slot: wearable_slot
  end

  private

  def room_message
    I18n.t 'game.wear_command.slack_success', 
      itemname: item.shortdesc, 
      slot: wearable_slot, 
      playername: player.name, 
      gender: player.third_person_possessive
  end

  def slot_occupied?
    occupied_slots.include? wearable_slot
  end

  def wearable_slot
    item.wearable.value
  end

  def occupied_slots
    player.inventory.worn.map{|x| x.wearable.value}
  end

end
