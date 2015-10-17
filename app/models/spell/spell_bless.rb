module Spell
  class SpellBless < Command::GameCommandBase

    include Command
    include PlayerUtil

    def initialize(game)
      super(game)
      @found_subject = SubjectFinder.new(game_command: self).perform
    end

    def perform
      return I18n.t 'game.look_command.not_found' if @found_subject.nil?
      slack_messenger.msg_room(room.slackid, message_to_room)
      I18n.t 'game.spell_create_beer.success',
        beername: @beer.shortdesc
    end

    private

    def message_to_room
      I18n.t 'game.spell_create_beer.slack_success',
        playername: player.name,
        gender: player.third_person_possessive,
        beername: @beer.shortdesc
    end

    def beer_to_create
      Item.by_keyword('beer').all.sample
    end
  end
end
