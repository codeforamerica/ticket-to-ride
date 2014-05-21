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

ActiveRecord::Schema.define(version: 20140513215219) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contact_people", force: true do |t|
    t.string  "relationship"
    t.string  "language"
    t.string  "mailing_street_address_1"
    t.string  "mailing_street_address_2"
    t.string  "mailing_zip_code"
    t.string  "phone"
    t.boolean "can_pickup_child",         default: false
  end

  create_table "district", force: true do |t|
    t.string "mailing_street_address_1", null: false
    t.string "mailing_street_address_2", null: false
    t.string "mailing_zip_code",         null: false
    t.string "phone",                    null: false
    t.date   "first_day_of_school"
  end

  create_table "guardians", force: true do |t|
    t.string  "first_name",                                 null: false
    t.string  "middle_name",                                null: false
    t.string  "last_name",                                  null: false
    t.string  "mailing_street_address_1",                   null: false
    t.string  "mailing_street_address_2",                   null: false
    t.string  "mailing_zip_code",                           null: false
    t.string  "cell_phone"
    t.string  "alt_phone"
    t.string  "alt_phone_type"
    t.string  "email"
    t.boolean "receive_emails",             default: true
    t.boolean "receive_sms",                default: true
    t.boolean "receive_postal_mail",        default: true
    t.boolean "receive_grade_notices",      default: true
    t.boolean "receive_conduct_notices",    default: true
    t.boolean "restricted",                 default: false
    t.string  "armed_service_branch"
    t.string  "armed_service_rank"
    t.string  "armed_service_duty_station"
  end

  create_table "schools", force: true do |t|
    t.string  "mailing_street_address_1", null: false
    t.string  "mailing_street_address_2", null: false
    t.string  "mailing_zip_code",         null: false
    t.string  "phone",                    null: false
    t.integer "district_id"
  end

  create_table "students", force: true do |t|
    t.string  "lasid"
    t.string  "ssid"
    t.string  "application_id"
    t.string  "first_name",                                 null: false
    t.string  "middle_name"
    t.string  "last_name",                                  null: false
    t.date    "birthday",                                   null: false
    t.string  "first_language"
    t.string  "second_language"
    t.date    "enrollment_date"
    t.date    "enrollment_confirm_date"
    t.date    "school_start_date"
    t.date    "estimated_graduation_date"
    t.boolean "iep",                        default: false
    t.boolean "p504",                       default: false
    t.boolean "bus_required",               default: false
    t.boolean "birth_certificate_verified", default: false
    t.boolean "residency_verified",         default: false
    t.boolean "lunch_provided",             default: false
    t.string  "home_street_address_1",                      null: false
    t.string  "home_street_address_2"
    t.string  "home_zip_code",                              null: false
    t.string  "mailing_street_address_1",                   null: false
    t.string  "mailing_street_address_2"
    t.string  "mailing_zip_code",                           null: false
  end

  create_table "welcome_messages", force: true do |t|
    t.string  "message",   null: false
    t.string  "language"
    t.integer "school_id"
  end

end
