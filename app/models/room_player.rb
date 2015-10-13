# == Schema Information
#
# Table name: room_players
#
#  id        :integer          not null, primary key
#  player_id :integer
#  room_id   :integer
#

class RoomPlayer < ActiveRecord::Base
  belongs_to :room
  belongs_to :player
end
