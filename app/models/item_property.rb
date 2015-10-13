# == Schema Information
#
# Table name: item_properties
#
#  id          :integer          not null, primary key
#  item_id     :integer
#  property_id :integer
#

class ItemProperty < ActiveRecord::Base

  belongs_to :item
  belongs_to :property

end
