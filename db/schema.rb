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

ActiveRecord::Schema.define(version: 20140905001809) do

  create_table "admin_users", force: true do |t|
    t.string   "name"
    t.string   "email",                       null: false
    t.integer  "user_role",                   null: false
    t.boolean  "active",      default: false
    t.integer  "district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true

  create_table "contact_people", force: true do |t|
    t.string   "relationship"
    t.string   "mailing_street_address_1"
    t.string   "mailing_street_address_2"
    t.string   "mailing_zip_code"
    t.boolean  "can_pickup_child"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                   default: false
    t.string   "mailing_city"
    t.string   "mailing_state"
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
  end

  create_table "districts", force: true do |t|
    t.string   "mailing_street_address_1"
    t.string   "mailing_street_address_2"
    t.string   "mailing_zip_code"
    t.string   "phone"
    t.date     "first_day_of_school"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                   default: false
    t.string   "mailing_city"
    t.string   "mailing_state"
    t.string   "name"
    t.string   "welcome_message"
    t.string   "confirmation_message"
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
    t.boolean  "birth_certificate_verified", default: false
    t.boolean  "residency_verified",         default: false
    t.boolean  "lunch_provided",             default: false
    t.string   "home_street_address_1"
    t.string   "home_street_address_2"
    t.string   "home_zip_code"
    t.integer  "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "home_city"
    t.string   "birth_country"
    t.boolean  "is_hispanic"
    t.string   "birth_city"
    t.string   "birth_state"
    t.datetime "guardian_complete_time"
    t.datetime "export_time"
    t.integer  "estimated_graduation_year"
    t.string   "home_state"
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
    t.string   "uri"
    t.integer  "req_type"
    t.integer  "district_id"
    t.integer  "authority_level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_required"
  end

end
