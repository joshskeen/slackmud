module Spell
  class SpellCreateBeer < Command::GameCommandBase
    def initialize(game)
      super(game)
      @beer = beer_to_create
    end

    def perform
      room.inventory.items << @beer
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
