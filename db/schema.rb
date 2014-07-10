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

ActiveRecord::Schema.define(version: 20140710061139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",      default: false
    t.integer  "district_id"
  end

  create_table "central_admins", force: true do |t|
    t.string   "name"
    t.boolean  "active",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clerks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",      default: false
    t.integer  "district_id"
  end

  create_table "contact_people", force: true do |t|
    t.string   "relationship"
    t.string   "language"
    t.string   "mailing_street_address_1"
    t.string   "mailing_street_address_2"
    t.string   "mailing_zip_code"
    t.boolean  "can_pickup_child",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                     default: false
    t.string   "mailing_city"
    t.string   "mailing_state"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "middle_name"
    t.boolean  "receive_grade_notices",      default: false
    t.boolean  "receive_conduct_notices",    default: false
    t.boolean  "receive_other_mail",         default: true
    t.boolean  "restricted",                 default: false
    t.string   "armed_service_branch"
    t.string   "armed_service_rank"
    t.string   "armed_service_duty_station"
    t.boolean  "lives_with_student",         default: false
    t.boolean  "has_custody",                default: false
    t.boolean  "has_court_order",            default: false
    t.string   "court_order_description"
  end

  create_table "contact_people_phone_numbers", id: false, force: true do |t|
    t.integer "contact_person_id"
    t.integer "phone_number_id"
  end

  create_table "custom_requirements", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "uri"
    t.integer  "req_type"
    t.integer  "district_id"
    t.integer  "authority_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "districts", force: true do |t|
    t.string   "mailing_street_address_1",                 null: false
    t.string   "mailing_street_address_2"
    t.string   "mailing_zip_code",                         null: false
    t.string   "phone",                                    null: false
    t.date     "first_day_of_school"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                   default: false
    t.string   "mailing_city"
    t.string   "mailing_state"
    t.string   "name"
  end

  create_table "phone_numbers", force: true do |t|
    t.string  "number"
    t.string  "extension"
    t.boolean "receives_sms",   default: false
    t.string  "priority_level"
  end

  create_table "schools", force: true do |t|
    t.string   "mailing_street_address_1"
    t.string   "mailing_street_address_2"
    t.string   "mailing_zip_code"
    t.string   "phone"
    t.integer  "district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                   default: false
    t.string   "mailing_city"
    t.string   "mailing_state"
    t.string   "name"
  end

  create_table "student_races", force: true do |t|
    t.integer  "student_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "primary_race"
    t.string   "additional_races"
  end

  create_table "students", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.date     "birthday"
    t.string   "first_language"
    t.date     "school_start_date"
    t.boolean  "iep",                        default: false
    t.boolean  "p504",                       default: false
    t.boolean  "bus_required",               default: false
    t.boolean  "birth_certificate_verified", default: false
    t.boolean  "residency_verified",         default: false
    t.boolean  "lunch_provided",             default: false
    t.string   "home_street_address_1"
    t.string   "home_street_address_2"
    t.string   "home_zip_code"
    t.string   "mailing_street_address_1"
    t.string   "mailing_street_address_2"
    t.string   "mailing_zip_code"
    t.integer  "school_id"
    t.integer  "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                     default: false
    t.string   "home_city"
    t.string   "mailing_city"
    t.string   "birth_country"
    t.boolean  "is_hispanic"
    t.string   "alt_home_street_address_1"
    t.string   "alt_home_street_address_2"
    t.string   "alt_home_city"
    t.string   "alt_home_zip_code"
    t.string   "alt_home_state"
    t.string   "nickname"
    t.string   "birth_city"
    t.string   "birth_state"
    t.datetime "guardian_complete_time"
    t.datetime "export_time"
    t.integer  "estimated_graduation_year"
    t.integer  "grade"
    t.string   "home_state"
    t.string   "mailing_state"
    t.boolean  "needs_special_services"
    t.boolean  "is_gifted"
    t.boolean  "has_learning_difficulties"
    t.string   "home_language"
    t.string   "guardian_language"
    t.boolean  "had_english_instruction"
    t.string   "prior_school_name"
    t.string   "prior_school_city"
    t.string   "prior_school_state"
  end

  create_table "students_contact_people", force: true do |t|
    t.integer "student_id"
    t.integer "contact_person_id"
  end

  create_table "welcome_messages", force: true do |t|
    t.string   "message",                     null: false
    t.string   "language"
    t.integer  "school_id"
    t.integer  "district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",      default: false
  end

end
