# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170323005800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "inventories", force: :cascade do |t|
  end

  create_table "inventory_items", force: :cascade do |t|
    t.integer "item_id"
    t.integer "inventory_id"
    t.boolean "worn",         default: false
  end

  create_table "item_properties", force: :cascade do |t|
    t.integer "item_id"
    t.integer "property_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "shortdesc"
    t.string "longdesc"
    t.string "name"
  end

  add_index "items", ["shortdesc"], name: "index_items_on_shortdesc", unique: true, using: :btree

  create_table "player_room_effects", force: :cascade do |t|
    t.integer "player_id"
    t.integer "room_id"
    t.string  "effect"
  end

  create_table "players", force: :cascade do |t|
    t.string   "gender"
    t.text     "description"
    t.string   "name"
    t.string   "slackid"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "inventory_id"
    t.boolean  "immortal",     default: false
  end

  add_index "players", ["inventory_id"], name: "index_players_on_inventory_id", using: :btree
  add_index "players", ["slackid"], name: "index_players_on_slackid", unique: true, using: :btree

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.string "value"
  end

  create_table "room_players", force: :cascade do |t|
    t.integer "player_id"
    t.integer "room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string  "title"
    t.text    "description"
    t.text    "slackid"
    t.integer "inventory_id"
  end

  add_index "rooms", ["slackid"], name: "index_rooms_on_slackid", unique: true, using: :btree

end
