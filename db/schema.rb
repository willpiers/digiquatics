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

ActiveRecord::Schema.define(version: 20140111003707) do

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone"
  end

  create_table "attendance_records", force: true do |t|
    t.integer  "patrons"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pool_id"
  end

  create_table "certification_names", force: true do |t|
    t.integer  "account_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certifications", force: true do |t|
    t.integer  "certification_name_id"
    t.integer  "user_id"
    t.datetime "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "issue_date"
  end

  create_table "chemical_records", force: true do |t|
    t.decimal  "chlorine_ppm",      precision: 6, scale: 2
    t.decimal  "chlorine_orp",      precision: 6, scale: 2
    t.decimal  "ph",                precision: 6, scale: 2
    t.decimal  "alkalinity",        precision: 6, scale: 2
    t.decimal  "calcium_hardness",  precision: 6, scale: 2
    t.decimal  "pool_temp",         precision: 6, scale: 2
    t.decimal  "air_temp",          precision: 6, scale: 2
    t.decimal  "si_index",          precision: 6, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date_time_reading"
  end

  create_table "locations", force: true do |t|
    t.integer  "account_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pools", force: true do |t|
    t.string   "name"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", force: true do |t|
    t.integer  "account_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "private_lessons", force: true do |t|
    t.string   "first_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "parent_first_name"
    t.string   "parent_last_name"
    t.string   "contact_method"
    t.string   "string"
    t.string   "sex"
    t.integer  "age"
    t.string   "instructor_gender"
    t.string   "notes"
    t.string   "day"
    t.string   "time"
    t.string   "preferred_location"
    t.integer  "ability_level"
    t.integer  "facility_level"
    t.integer  "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",              default: true
    t.string   "suit_size"
    t.string   "shirt_size"
    t.string   "sex"
    t.datetime "date_of_birth"
    t.datetime "date_of_hire"
    t.string   "phone_number"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",               default: false
    t.integer  "account_id"
    t.integer  "location_id"
    t.integer  "position_id"
    t.integer  "femalesuit"
    t.text     "notes"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "employee_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end