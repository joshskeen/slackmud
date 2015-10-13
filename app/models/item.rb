# == Schema Information
#
# Table name: items
#
#  id        :integer          not null, primary key
#  shortdesc :string
#  longdesc  :string
#  name      :string
#

class Item < ActiveRecord::Base
  include ItemUtil

  has_many :item_properties
  has_many :properties, through: :item_properties
  scope :by_keyword, -> (keyword = nil) {
    where("shortdesc LIKE ?", "%#{keyword}%") 
  }

  scope :edible, -> {
    includes(:properties)
      .where("properties.name = 'edible'")
      .references(:properties)
  }

  scope :wearable, -> {
    includes(:properties)
      .where("properties.name = 'wearable'")
      .references(:properties)
  }
  #todo : with_property scope

  def fetch_property(name)
    properties.where("name = ?", name).first
  end

  def formatted_description
    I18n.t 'game.item_formatted_description', description: longdesc 
  end

  def self.first_by_keyword(keyword)
    by_keyword(keyword).first
  end

end
