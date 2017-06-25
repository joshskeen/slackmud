class InventoryCommand < GameCommandBase
  include FormatUtils

  def perform
    return I18n.t 'game.inventory_command.nothing' if player.inventory.unworn.length == 0
    format_inventory(player.inventory.unworn, player.inventory) 
  end

end
