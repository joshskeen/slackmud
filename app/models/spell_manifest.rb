class SpellManifest < GameCommandBase

  class SpellManifestWorker < BaseWorker
    def perform(room_slackid, item_id, message)
      item = Item.find(item_id)
      room = Room.where(slackid: room_slackid).first
      room.inventory.items << item
      slack_messenger.msg_room(room_id, message)
    end
  end

  def perform
    return I18n.t 'game.spell_manifest.immortal_required' if !player.immortal?
    return I18n.t 'game.spell_manifest.not_found' if !item_exists?
    slack_messenger.msg_room(room.slackid, format_room_message)
    SpellManifestWorker.perform_in(1.second.from_now,
                                   room.slackid,
                                   item.id, 
                                   worker_success_message)
    I18n.t 'game.spell_manifest.success'
  end

  private

  def worker_success_message
    I18n.t 'game.spell_manifest.worker_success',
           playername: player.name,
           itemname: item.shortdesc
  end

  def format_room_message
    I18n.t 'game.spell_manifest.slack_success',
           playername: player.name,
           gender: player.third_person_possessive
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
