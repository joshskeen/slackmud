class HelpCommand < GameCommandBase

  def topics
    {
      "look": 'game.help.look',
      "get": 'game.help.give'
    }.with_indifferent_access
  end

  def perform
    return I18n.t 'game.help.info' if @arguments.blank?
    return I18n.t topics[@arguments] if topics.has_key?(@arguments)
    I18n.t 'game.help.no_help_file', topic: @arguments
  end

end
