class EmoteCommand < GameCommandBase
  include PlayerUtil

  # smirk 0 0
  # You smirk.
  # $n smirks.
  # You smirk at $S saying.
  # $n smirks at $N's saying.
  # $n smirks at your saying.
  # You want to smirk to whom?
  # You smirk at yourself.  Okay.....
  # $n smirks at $s own 'wisdom'.

  def perform
    room_message
    user_message
  end

  private

  def social_target_self_player_message
    format_string = social[7]
    format_string.gsub(/\$n/, player.name)
  end

  def social_target_self_room_message
    format_string = social[8]
    format_string
      .gsub(/\$n/, player.name)
      .gsub(/\$s/, player.third_person_possessive)
  end

  # snicker 0 0
  # You snicker softly.
  # $n snickers softly.
  # You snicker with $M about your shared secret.
  # $n snickers with $N about their shared secret.
  # $n snickers with you about your shared secret.
  # Huh?
  # You snicker at your own evil thoughts.
  # $n snickers at $s own evil thoughts.

  def social_target_found_player_message
    format_string = social[3]
    format_string.gsub(/\$M/, target_player_in_room.name)
      .gsub(/\$S/, target_player_in_room.name + "'s")
  end

  def social_target_found_room_message
    format_string = social[4]
    return nil if format_string.blank?
    format_string.gsub(/\$n/, player.name)
      .gsub(/\$N/, target_player_in_room.name)
  end

  def social_no_target_player_message
    social[1]
  end

  def social_no_target_room_message
    format_string = social[2]
    return nil if format_string.blank?
    format_string.gsub(/\$n/, player.name)
      .gsub(/\$s/, player.third_person_possessive)
  end

  def social_target_not_found_player_message
    social[6]
  end

  def user_message
    return I18n.t 'game.emote_command.emote_not_found' if social_not_found?
    return social_no_target_player_message if @target.blank?
    if @target.present?
      if room_has_player?
        if target_player_in_room == player
          return social_target_self_player_message
        else
          return social_target_found_player_message
        end
      else
        return social_target_not_found_player_message
      end
    end
  end

  def room_message
    message = nil
    return if social_not_found?
    message = social_no_target_room_message if @target.blank?
    if @target.present?
      if room_has_player?
        if target_player_in_room == player
          message = social_target_self_room_message
        else
          message = social_target_found_room_message
        end
      end
    end
    return if message.blank?
    slack_messenger.msg_room(room.slackid, message)
  end

  def social_not_found?
    !socials.key?(first_arg)
  end

  def file
    @file ||= File.read(File.join(Rails.root, 'config', 'social.are.txt'))
  end

  def social
    socials[first_arg]
  end

  def socials
    hash = {}
    file.split(/\n\n/)
      .map { |a| a.split(/\n/) }
      .map { |a| hash[a[0].split(' ').first] = a }
    hash
  end
end
