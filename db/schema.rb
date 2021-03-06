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

ActiveRecord::Schema.define(version: 20140922001326) do

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.boolean  "slides_group_email",              default: false
    t.boolean  "slides_admin_email",              default: false
    t.boolean  "slides_location_email",           default: false
    t.boolean  "maintenance_group_email",         default: false
    t.boolean  "maintenance_admin_email",         default: false
    t.boolean  "maintenance_location_email",      default: false
    t.boolean  "chemical_records_group_email",    default: false
    t.boolean  "chemical_records_admin_email",    default: false
    t.boolean  "chemical_records_location_email", default: false
  end

  create_table "attendance_records", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "availabilities", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day"
    t.datetime "start_time"
    t.datetime "end_time"
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
    t.decimal  "free_chlorine_ppm",     precision: 6, scale: 2
    t.decimal  "chlorine_orp",          precision: 6, scale: 2
    t.decimal  "ph",                    precision: 6, scale: 2
    t.decimal  "alkalinity",            precision: 6, scale: 2
    t.decimal  "calcium_hardness",      precision: 6, scale: 2
    t.decimal  "pool_temp",             precision: 6, scale: 2
    t.decimal  "air_temp",              precision: 6, scale: 2
    t.decimal  "si_index",              precision: 6, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "time_stamp"
    t.text     "si_status"
    t.text     "si_recommendation"
    t.integer  "user_id"
    t.integer  "pool_id"
    t.string   "water_clarity"
    t.decimal  "total_chlorine_ppm",    precision: 6, scale: 2
    t.decimal  "combined_chlorine_ppm", precision: 6, scale: 2
    t.integer  "location_id"
  end

  create_table "daily_todos", force: true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_groups", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_email"
    t.integer  "user_id"
    t.integer  "account_id"
    t.string   "user_first_name"
    t.string   "user_last_name"
  end

  create_table "help_desks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "urgency"
    t.integer  "user_id"
    t.integer  "location_id"
    t.string   "help_desk_attachment_file_name"
    t.string   "help_desk_attachment_content_type"
    t.integer  "help_desk_attachment_file_size"
    t.datetime "help_desk_attachment_updated_at"
    t.text     "description"
    t.boolean  "issue_status",                      default: true
    t.text     "issue_resolution_description"
    t.integer  "closed_user_id"
    t.datetime "closed_date_time"
  end

  create_table "locations", force: true do |t|
    t.integer  "account_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packages", force: true do |t|
    t.integer "account_id"
    t.string  "name"
  end

  create_table "participants", force: true do |t|
    t.string  "private_lesson_id"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "sex"
    t.integer "age"
    t.integer "skill_level_id"
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

  create_table "preventative_lists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "task_type"
  end

  create_table "private_lessons", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number"
    t.string   "parent_first_name"
    t.string   "parent_last_name"
    t.string   "contact_method"
    t.string   "preferred_location"
    t.integer  "user_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.boolean  "queue_status"
    t.integer  "account_id"
    t.string   "instructor_gender"
    t.text     "notes"
    t.text     "lesson_objective"
    t.integer  "location_id"
    t.datetime "claimed_on"
    t.datetime "completed_on"
    t.boolean  "sunday_morning"
    t.boolean  "sunday_afternoon"
    t.boolean  "sunday_evening"
    t.boolean  "monday_morning"
    t.boolean  "monday_afternoon"
    t.boolean  "monday_evening"
    t.boolean  "tuesday_morning"
    t.boolean  "tuesday_afternoon"
    t.boolean  "tuesday_evening"
    t.boolean  "wednesday_morning"
    t.boolean  "wednesday_afternoon"
    t.boolean  "wednesday_evening"
    t.boolean  "thursday_morning"
    t.boolean  "thursday_afternoon"
    t.boolean  "thursday_evening"
    t.boolean  "friday_morning"
    t.boolean  "friday_afternoon"
    t.boolean  "friday_evening"
    t.boolean  "saturday_morning"
    t.boolean  "saturday_afternoon"
    t.boolean  "saturday_evening"
    t.text     "meeting_time_agreement"
    t.integer  "package_id"
    t.string   "secondary_phone_number"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "shift_reports", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "location_id"
    t.boolean  "report_filed"
    t.string   "attachment_front_file_name"
    t.string   "attachment_front_content_type"
    t.integer  "attachment_front_file_size"
    t.datetime "attachment_front_updated_at"
    t.string   "attachment_back_file_name"
    t.string   "attachment_back_content_type"
    t.integer  "attachment_back_file_size"
    t.datetime "attachment_back_updated_at"
  end

  create_table "shifts", force: true do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.integer  "position_id"
    t.datetime "start_time"
    t.datetime "end_time"
  end

  create_table "sign_ups", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "locations"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skill_levels", force: true do |t|
    t.integer "account_id"
    t.string  "name"
  end

  create_table "slide_inspection_tasks", force: true do |t|
    t.integer  "slide_inspection_id"
    t.string   "task_name"
    t.boolean  "completed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slide_inspections", force: true do |t|
    t.integer  "slide_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.boolean  "all_ok",     default: false
  end

  create_table "slides", force: true do |t|
    t.integer  "location_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_requests", force: true do |t|
    t.integer  "shift_id"
    t.datetime "processed_on"
    t.integer  "processed_by_user_id"
    t.string   "processed_by_first_name"
    t.string   "processed_by_last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                  default: true
    t.integer  "user_id"
    t.integer  "sub_user_id"
    t.string   "sub_first_name"
    t.string   "sub_last_name"
    t.boolean  "approved"
    t.boolean  "processed",               default: false
  end

  create_table "time_off_requests", force: true do |t|
    t.integer  "user_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.text     "reason"
    t.string   "approved_by_user_id"
    t.datetime "approved_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                  default: true
    t.boolean  "approved",                default: false
    t.integer  "location_id"
    t.string   "processed_by_last_name"
    t.string   "processed_by_first_name"
    t.boolean  "all_day"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                                          default: true
    t.string   "suit_size"
    t.string   "shirt_size"
    t.string   "sex"
    t.datetime "date_of_birth"
    t.datetime "date_of_hire"
    t.string   "phone_number"
    t.boolean  "admin",                                           default: false
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
    t.string   "emergency_first"
    t.string   "emergency_last"
    t.string   "emergency_phone"
    t.string   "grouping"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "email",                                           default: "",    null: false
    t.string   "encrypted_password",                              default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "secondary_phone_number"
    t.decimal  "payrate",                 precision: 4, scale: 2
    t.boolean  "private_lesson_access"
    t.boolean  "chemical_records_access"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
