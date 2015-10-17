module Command
  class LookCommand < GameCommandBase
    include PlayerUtil

    def perform
      @found_subject = SubjectFinder.new(game_command: self).perform
      return I18n.t 'game.look_command.not_found' if @found_subject.nil?
      room_message
      player_message
    end

    private

    def player_message
      objectname = format_objectname
      objectname = 'yourself' if looks_self?
      I18n.t 'game.look_command.success',
             description: @found_subject.formatted_description,
             objectname: objectname
    end

    def room_message
      slack_messenger.msg_room(room.slackid, format_slack_message)
    end

    def format_slack_message
      if @found_subject.is_a?(Room)
        return I18n.t 'game.look_command.slack_success_room', playername: player.name
      end
      objectname = format_objectname
      objectname = player.third_person_intensive if looks_self?
      I18n.t 'game.look_command.slack_success',
             playername: player.name,
             objectname: objectname
    end

    def format_objectname
      return @found_subject.name if @found_subject.is_a?(Player)
      return I18n.t 'game.look_command.room_objectname' if @found_subject.is_a?(Room)
      @found_subject.shortdesc
    end
  end
end
