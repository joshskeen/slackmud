class LookCommand < GameCommandBase
  include PlayerUtil

  def perform
    @found_subject = find_subject
    return I18n.t 'game.look_command.not_found' if @found_subject.nil?
    room_message
    player_message
  end

  private

  def player_message
    objectname = format_objectname
    objectname = "yourself" if looks_self? 
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

  def looks_room?
    @arguments.blank? || @arguments == "room"
  end

  def looks_self?
    @found_subject == player
  end

  def find_subject
    return room if looks_room?
    return player if @arguments == "self"
    return player_by_name if @arguments.present? and player_by_name.present?
    return player_item if player_item.present?
    return room_item if room_item.present?  
  end

  def player_by_name
    room.players.by_name(@arguments).first
  end

end
