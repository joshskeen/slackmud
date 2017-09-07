# == Schema Information
#
# Table name: rooms
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  slackid      :text
#  inventory_id :integer
#

class Room < ActiveRecord::Base
  include FormatUtils

  belongs_to :inventory
  has_many :room_players
  has_many :players, through: :room_players
  delegate :add_item,
    :remove_item,
    :nerdcoins,
    :remove_funds,
    :possesses?,
    :has_quantity?,
    :add_funds,
    :has_funds?,
    to: :inventory

  def item(keyword)
    inventory.by_keyword(keyword)
  end

  def formatted_description
    #todo - decorations!
    I18n.t 'game.room_formatted_description',
      nerdcoins: formatted_nerdcoins,
      description: description,
      inventory: formatted_inventory
  end

  def formatted_nerdcoins
   nerdcoins > 0 ? "#{nerdcoins} nerdcoins \n" : ""
  end

  def formatted_inventory
    return I18n.t 'game.inventory_command.nothing' if inventory.no_items?
    format_inventory(inventory.items, inventory)
  end

  def player_by_name(name)
    player = players.by_name(name).first
    return nil if !player
    player.effects.where(name: Effect::EFFECT_INVIZED).size > 0 ? nil : player
  end

  def self.find_or_create_by_slackid(slackid)
    room = Room.where(slackid: slackid).first
    if room.nil?
      channel_info_response  = channel_info(slackid)
      if channel_info_response.has_key?(:error)
        return generic_room_from_slackid(slackid)
      end
      room = Room.room_from_channel_info_response(channel_info_response)
    end
    return room
  end

  def self.create_room_from_channel(channel)
    attrs = {
      title: channel["name"],
      description: channel["purpose"]["value"],
      slackid: channel["id"],
      inventory: Inventory.create
    }
    Room.create(attrs)
  end

  def self.room_from_channel_info_response(channel_info)
    response = channel_info[:channel]
    attrs = {
      title: response[:name],
      description: response[:purpose]["value"],
      slackid: response[:id],
      inventory: Inventory.create,
      players: players_from_channel_info(channel_info)
    }
    Room.create(attrs)
  end

  def self.players_from_channel_info(channel_info)
    response = channel_info[:channel]["members"]
    response.map {|x| Player.by_slackid(x).first}.compact
  end

  def self.generic_room_from_slackid(slackid)
    attrs = {
      title: I18n.t('room.generic_title'),
      description: I18n.t('room.generic_description'),
      slackid: slackid,
      inventory: Inventory.create
    }
    Room.create(attrs)
  end

  def self.channel_info(slackid)
    Slack::Client.new.channels_info(channel: slackid).with_indifferent_access
  end
end
