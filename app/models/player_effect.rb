# == Schema Information
#
# Table name: player_effects
#
#  id        :integer          not null, primary key
#  player_id :integer
#  effect_id :integer
#

class PlayerEffect < ActiveRecord::Base

  belongs_to :player
  belongs_to :effect

end
