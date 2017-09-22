class BuyCommand < GameCommandBase
  include FormatUtils
  include PlayerUtil

  def perform
    return I18n.t 'game.list_command.no_shopkeeper' if !shopkeeper
    return I18n.t 'game.buy_command.no_target' if arguments.empty?
    return I18n.t 'game.buy_command.no_item' if item_not_found
    return insufficient_funds_message if !can_purchase?
    do_purchase
    slack_messenger.msg_room(room.slackid, room_message)
    player_success_message
  end

  private

  def room_message
    item = shopkeeper_item.first
    return I18n.t 'game.buy_command.slack_success',
        itemname: item.shortdesc,
        price: item.value,
        shopkeepername: shopkeeper.name,
        playername: player.name
  end

  def do_purchase
    item = shopkeeper_item.first
    player.remove_funds(item.value)
    player.add_item(item, 1)
  end

  def player_success_message
    item = shopkeeper_item.first
  return I18n.t 'game.buy_command.success',
    itemname: item.shortdesc,
    price: item.value,
    shopkeepername: shopkeeper.name
  end

  def insufficient_funds_message
    return I18n.t 'game.buy_command.insufficient_funds',
      itemname: shopkeeper_item.first.shortdesc
  end

  def can_purchase?
    player.nerdcoins >= shopkeeper_item.first.value
  end

  def item_not_found
    shopkeeper_item.count == 0
  end
  def shopkeeper_item
    shopkeeper.inventory.items.by_keyword(arguments)
  end

  def shopkeeper
    room.npcs.where(shopkeeper: true).first
  end

end
