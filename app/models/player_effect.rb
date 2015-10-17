class PlayerEffect < ActiveRecord::Base
  belongs_to :player
  belongs_to :effect
end
