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

ActiveRecord::Schema.define(version: 20150511103540) do

  create_table "game_sessions", force: :cascade do |t|
    t.date     "play_date"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "finished",   default: false, null: false
  end

  create_table "game_sessions_users", force: :cascade do |t|
    t.integer  "game_session_id"
    t.integer  "user_id"
    t.integer  "fraction",        null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "game_sessions_users", ["game_session_id", "user_id"], name: "index_game_sessions_users_on_game_session_id_and_user_id"
  add_index "game_sessions_users", ["game_session_id"], name: "index_game_sessions_users_on_game_session_id"
  add_index "game_sessions_users", ["user_id"], name: "index_game_sessions_users_on_user_id"

  create_table "rounds", force: :cascade do |t|
    t.integer  "game_session_id"
    t.integer  "winner"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "rounds", ["game_session_id"], name: "index_rounds_on_game_session_id"

  create_table "rounds_users", force: :cascade do |t|
    t.integer  "round_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rounds_users", ["round_id", "user_id"], name: "index_rounds_users_on_round_id_and_user_id"
  add_index "rounds_users", ["round_id"], name: "index_rounds_users_on_round_id"
  add_index "rounds_users", ["user_id"], name: "index_rounds_users_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_sessions_count", default: 0, null: false
  end

end
