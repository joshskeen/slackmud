class MaterializeCommand < GameCommandBase

  def perform
    return I18n.t 'game.materialize_command.immortal_required' if !player.immortal?
    return I18n.t 'game.materialize_command.not_found' if !item_exists?
    player.inventory.items << item_by_keyword
  end

  private 

  def item_exists?
    item_by_keyword.present?
  end

  def item_by_keyword
    Item.by_keyword(arguments).first
  end

end
