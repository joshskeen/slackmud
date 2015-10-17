module Command
  class CastCommand < GameCommandBase
    SPELLS = {
      "create beer": Spell::SpellCreateBeer,
      "bless":       Spell::SpellBless
    }.with_indifferent_access

    def perform
      spell = SPELLS[@arguments]
      spell = SPELLS[@arguments + ' ' + @target.to_s] if spell.nil?
      return I18n.t 'game.cast_command.cast_what' if @arguments.empty?
      return I18n.t 'game.cast_command.spell_not_found' if spell.nil?
      # TODO: mana requirements, level requirements, etc
      spell.new(game).perform
    end
  end
end
