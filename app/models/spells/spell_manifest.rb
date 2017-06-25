class SpellManifest < GameCommandBase

  def perform
    return I18n.t 'game.spell_manifest.immortal_required' if !player.immortal?
    return I18n.t 'game.spell_manifest.not_found' if !item_exists?
    slack_messenger.msg_room(room.slackid, format_room_message)
    room.inventory.items << item
    I18n.t 'game.spell_manifest.success'
  end

  private

  def format_room_message
    I18n.t 'game.spell_manifest.slack_success',
           playername: player.name,
           gender: player.third_person_possessive,
           itemname: item.shortdesc
  end

  def item_exists?
    item_by_keyword.present?
  end

  def item
    item_by_keyword
  end

  def item_by_keyword
    Item.by_keyword(@target).first
  end
end
