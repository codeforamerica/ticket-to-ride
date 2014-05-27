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

ActiveRecord::Schema.define(version: 20140527222228) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "admins", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clerks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_people", force: true do |t|
    t.string  "relationship"
    t.string  "language"
    t.string  "mailing_street_address_1"
    t.string  "mailing_street_address_2"
    t.string  "mailing_zip_code"
    t.string  "phone"
    t.boolean "can_pickup_child",         default: false
    t.integer "guardian_id"
  end

  create_table "districts", force: true do |t|
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
    t.integer "student_id"
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
    t.integer "school_id"
  end

  create_table "welcome_messages", force: true do |t|
    t.string  "message",     null: false
    t.string  "language"
    t.integer "school_id"
    t.integer "district_id"
  end

end
