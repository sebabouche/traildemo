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

ActiveRecord::Schema.define(version: 20151128104942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authorships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "thing_id"
    t.integer  "confirmed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cache_versions", force: :cascade do |t|
    t.string   "name"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "weight"
    t.integer  "deleted"
    t.integer  "thing_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "endorsements", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "thing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "things", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.text     "image_meta_data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "things_users", id: false, force: :cascade do |t|
    t.integer "thing_id", null: false
    t.integer "user_id",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.text     "image_meta_data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "auth_meta_data"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

end
