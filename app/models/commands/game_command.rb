class GameCommand < GameCommandBase

  def commands 
    {
      "help": HelpCommand,
      "drop": DropCommand,
      "give": GiveCommand,
      "wear": WearCommand,
      "remove": RemoveCommand,
      "look": LookCommand, 
      "examine": LookCommand,
      "get": GetCommand,
      "inventory": InventoryCommand,
      "eat": EatCommand,
      "drink": EatCommand,
      "emote": EmoteCommand,
      "cast": CastCommand,
      "list": ListCommand,
      "buy": BuyCommand,
      "viz": VizCommand,
      "roll": RollCommand,
      "materialize": MaterializeCommand,
    }.with_indifferent_access
  end

  def perform
    return commands[command].new(@game).perform if commands.has_key? command
    I18n.t 'game.command_not_found'
  end

end
