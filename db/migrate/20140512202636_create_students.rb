class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string  :lasid # local school ID
      t.string  :ssid # state school ID
      t.string  :application_id # the number associated with this enrollment application

      t.string  :first_name, null: false # student name
      t.string  :middle_name
      t.string  :last_name, null: false
      t.date    :birth_date, null: false
      t.string  :first_language # the language a student speaks primarily
      t.string  :second_language # another language a student speaks

      t.date    :enrollment_date # date the enrollment application began
      t.date    :enrollment_confirm_date # date the application is completed

      t.date    :school_start_date # date student starts school
      t.date    :estimated_graduation_date #date the student should graduate high school

      t.boolean :iep, default: false # true if the student needs an individualized education program
      t.boolean :p504, default: false # true if the student should be in a 504 program
      t.boolean :bus_required, default: false # true if the student needs bus transportation
      t.boolean :birth_certificate_verified, default: false # true if the school staff has verified the birth certificate of the student
      t.boolean :residency_verified, default: false # school staff has verified the student's address
      t.boolean :lunch_provided, default: false # free or reduced lunch, true if qualified

      t.string  :home_street_address_1, null: false # this is the address where the student lives
      t.string  :home_street_address_2
      t.string  :home_zip_code, null: false

      t.string  :mailing_street_address_1, null: false # this is the address where the student lives
      t.string  :mailing_street_address_2
      t.string  :mailing_zip_code, null: false
    end
  end
end
