class ListCommand < GameCommandBase
  include FormatUtils
  include PlayerUtil

  def perform
    return I18n.t 'game.list_command.no_shopkeeper' if !shopkeeper
    return I18n.t 'game.list_command.shop_summary',
      shopkeepername: shopkeeper.name, 
      formatted_shop_list: formatted_shop_list
  end

  private

  def shopkeeper
    room.npcs.where(shopkeeper: true).first
  end

  def formatted_shop_list
    format_shop_inventory(shopkeeper.inventory)
  end

end
