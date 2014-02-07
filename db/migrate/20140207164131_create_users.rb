class CreateUsers < ActiveRecord::Migration
  def change
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
      t.string   "emergency_first"
      t.string   "emergency_last"
      t.string   "emergency_phone"
      t.string   "nickname"
      t.integer  "payrate"
      t.string   "grouping"
      t.string   "address1"
      t.string   "address2"
      t.string   "city"
      t.string   "state"
      t.string   "zipcode"
    end
  end
end
