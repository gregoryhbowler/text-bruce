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

ActiveRecord::Schema.define(version: 20150831202359) do

  create_table "links", force: :cascade do |t|
    t.string   "in_url"
    t.text     "out_url"
    t.integer  "http_status", default: 301
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["in_url"], name: "index_links_on_in_url"

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "playlist_attributes", force: :cascade do |t|
    t.string   "mood"
    t.string   "genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "playlists", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.string   "spotify_link"
    t.string   "apple_link"
    t.string   "youtube_link"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string   "title"
    t.string   "artist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "phone_number"
    t.string   "phone_pin"
    t.boolean  "phone_verified",  default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end
