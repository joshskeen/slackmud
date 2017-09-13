class ListCommand < GameCommandBase
  include FormatUtils
  include PlayerUtil

  def perform
    return I18n.t 'game.list_command.no_shopkeeper' if !shopkeeper
    return I18n.t 'game.list_command.shop_summary',
      formatted_shop_list: formatted_shop_list
  end

  private

  def shopkeeper
    if arguments.empty?
      room.players.where(npc: true, shopkeeper: true).first
    else
      room.players.by_name(arguments).where(npc: true, shopkeeper: true).first
    end
  end

  def formatted_shop_list
    format_shop_inventory(shopkeeper.inventory)
  end

end
