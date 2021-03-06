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

ActiveRecord::Schema.define(version: 20141112192826) do

  create_table "admin_users", force: true do |t|
    t.string   "name"
    t.string   "email",                               null: false
    t.integer  "user_role",                           null: false
    t.integer  "district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "contact_people", force: true do |t|
    t.string   "relationship"
    t.boolean  "can_pickup_child"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                  default: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.boolean  "receive_grade_notices"
    t.boolean  "receive_conduct_notices"
    t.boolean  "receive_other_mail"
    t.boolean  "lives_with_student"
    t.integer  "student_id"
    t.string   "main_phone"
    t.boolean  "main_phone_can_sms"
    t.string   "secondary_phone"
    t.string   "secondary_phone_can_sms"
    t.string   "work_phone"
    t.string   "work_phone_can_sms"
    t.boolean  "is_guardian"
    t.string   "armed_service_status"
    t.string   "street_address_1"
    t.string   "street_address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
  end

  create_table "districts", force: true do |t|
    t.string   "street_address_1"
    t.string   "street_address_2"
    t.string   "zip_code"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",               default: false
    t.string   "city"
    t.string   "state"
    t.string   "name"
    t.string   "welcome_message"
    t.string   "confirmation_message"
    t.string   "sftp_url"
    t.string   "sftp_path"
    t.string   "sftp_username"
    t.string   "sftp_password_hash"
    t.integer  "export_frequency"
    t.string   "welcome_title"
    t.string   "welcomer_name"
    t.string   "welcomer_title"
    t.string   "confirmation_title"
    t.string   "url"
    t.string   "email"
  end

  add_index "districts", ["name"], name: "index_districts_on_name", unique: true

  create_table "student_races", force: true do |t|
    t.integer  "student_id", null: false
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "race",       null: false
  end

  create_table "students", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.date     "birthday"
    t.string   "first_language"
    t.boolean  "iep"
    t.boolean  "p504"
    t.string   "street_address_1"
    t.string   "street_address_2"
    t.string   "zip_code"
    t.integer  "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city"
    t.string   "birth_country"
    t.boolean  "is_hispanic"
    t.string   "birth_city"
    t.string   "birth_state"
    t.datetime "guardian_complete_time"
    t.datetime "export_time"
    t.integer  "estimated_graduation_year"
    t.string   "state"
    t.boolean  "needs_special_services"
    t.boolean  "has_learning_difficulties"
    t.string   "home_language"
    t.string   "prior_school_name"
    t.string   "prior_school_city"
    t.string   "prior_school_state"
    t.string   "previous_grade"
    t.string   "confirmation_code"
    t.integer  "district_id"
  end

  add_index "students", ["confirmation_code"], name: "index_students_on_confirmation_code", unique: true

  create_table "students_contact_people", force: true do |t|
    t.integer "student_id"
    t.integer "contact_person_id"
  end

  create_table "supplemental_materials", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "link_url"
    t.integer  "district_id"
    t.integer  "authority_level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_required"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.boolean  "bring_documentation"
  end

end
