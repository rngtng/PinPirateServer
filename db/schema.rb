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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111231123133) do

  create_table "events", :force => true do |t|
    t.integer  "game_id"
    t.string   "type"
    t.string   "raw_data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["game_id"], :name => "index_events_on_game_id"

  create_table "games", :force => true do |t|
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score",        :default => 0
    t.integer  "slot",         :default => 1
  end

  add_index "games", ["player_id"], :name => "index_games_on_player_id"

  create_table "players", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
