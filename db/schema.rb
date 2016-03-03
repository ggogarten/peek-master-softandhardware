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

ActiveRecord::Schema.define(version: 20160227180706) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "house_users", force: :cascade do |t|
    t.integer  "house_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "house_users", ["house_id"], name: "index_house_users_on_house_id", using: :btree
  add_index "house_users", ["user_id"], name: "index_house_users_on_user_id", using: :btree

  create_table "houses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "house_id"
  end

  add_index "pictures", ["house_id"], name: "index_pictures_on_house_id", using: :btree
  add_index "pictures", ["user_id"], name: "index_pictures_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "phone_number"
    t.string   "zipcode"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_foreign_key "house_users", "houses"
  add_foreign_key "house_users", "users"
  add_foreign_key "pictures", "houses"
  add_foreign_key "pictures", "users"
end
