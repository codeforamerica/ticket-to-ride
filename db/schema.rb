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

ActiveRecord::Schema.define(version: 20140512202636) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

end
