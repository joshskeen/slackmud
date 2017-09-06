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

  has_many :player_effects
  has_many :effects, through: :player_effects

  delegate :add_item,
           :remove_item,
           :add_funds,
           :remove_funds,
           :possesses?,
           :has_funds?,
           :has_quantity?,
           :nerdcoins,
           to: :inventory

  scope :by_slackid, -> (slackid) { where(slackid: slackid) }
  scope :by_name, lambda { |name|
    where('name LIKE ?', "%#{name}%")
  }

  def item(keyword)
    inventory.by_keyword(keyword)
  end

  def invisible?
    effects.where(name: Effect::EFFECT_INVIZED).count > 0
  end

  def name
    invisible? ? "someone" : self[:name]
  end

  def distinct_inventory
    inventory.unworn.order(:shortdesc).distinct
  end

  def formatted_description
    I18n.t 'game.player_formatted_description',
           description: description,
           effects: player_effects_description,
           details: player_details,
           equipment: player_equipment_description
  end

  def has_item?(keyword)
    inventory.has_item?(keyword)
  end

  def third_person_intensive_alt
    return 'him' if gender == 'male'
    return 'her' if gender == 'female'
    'it'
  end

  def third_person_intensive
    return 'himself' if gender == 'male'
    return 'herself' if gender == 'female'
    'itself'
  end

  def third_person_subject
    return 'he' if gender == 'male'
    return 'she' if gender == 'female'
    'it'
  end

  def third_person_possessive
    return 'his' if gender == 'male'
    return 'her' if gender == 'female'
    'its'
  end

  def self.create_player_by_slack_info(slackid, slackname, gender)
    create(slackid: slackid,
           gender: gender,
           description: "There's nothing special about them.",
           name: slackname,
           inventory: Inventory.create)
  end

  def self.find_or_create_player_by_slack_info(slackid, slackname)
    player = by_slackid(slackid).first
    create_player_by_slack_info(slackid, slackname) if player.nil?
    player
  end

  def self.find_or_create_player_by_slack_request(slack_request)
    find_or_create_player_by_slack_info(slack_request.slackid, slack_request.slackname)
  end
end
