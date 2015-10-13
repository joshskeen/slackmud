# == Schema Information
#
# Table name: players
#
#  id           :integer          not null, primary key
#  gender       :string
#  description  :text
#  name         :string
#  slackid      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  inventory_id :integer
#

class Player < ActiveRecord::Base
  include PlayerFormatUtil, 
    FormatUtils
  belongs_to :inventory

  delegate :add_item,
    :remove_item,
    :possesses?,
    :has_quantity?,
    to: :inventory

  scope :by_slackid, -> (slackid) {where(slackid: slackid)}
  scope :by_name, -> (name) {
    where("name LIKE ?", "%#{name}%")
  }

  def item(keyword)
    inventory.by_keyword(keyword)
  end

  def distinct_inventory
    inventory.unworn.order(:shortdesc).distinct
  end

  def formatted_description
    I18n.t 'game.player_formatted_description', 
      description: description, 
      details: player_details, 
      equipment: player_equipment_description
  end

  def has_item?(keyword)
    inventory.has_item?(keyword)
  end

  def third_person_intensive
    return "himself" if gender == "male"
    return "herself" if gender == "female"
    "itself"
  end

  def third_person_possessive
    return "his" if gender == "male"
    return "her" if gender == "female"
    "its"
  end

  def self.find_or_create_player_by_slack_info(slackid, slackname)
    player = by_slackid(slackid).first
    if player.nil?
      player = create(slackid: slackid, 
                      gender: "male",
                      description: "There's nothing special about them.",
                      name: slackname, 
                      inventory: Inventory.create)
    end
    return player
  end

  def self.find_or_create_player_by_slack_request(slack_request)
    find_or_create_player_by_slack_info(slack_request.slackid, slack_request.slackname)
  end

end
