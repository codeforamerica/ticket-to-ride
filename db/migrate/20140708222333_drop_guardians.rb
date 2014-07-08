class DropGuardians < ActiveRecord::Migration
  def up
    drop_table :guardians
  end

  def down
    create_table :guardians do |t|
      # Name
      t.string :first_name, null: false
      t.string :middle_name, null: false
      t.string :last_name, null: false

      # Postal mail / residency info
      t.string :mailing_street_address_1, null: false
      t.string :mailing_street_address_2, null: false
      t.string :mailing_city
      t.string :mailing_state
      t.string :mailing_zip_code, null: false

      # Electronic contact information
      t.string :cell_phone
      t.string :alt_phone
      t.string :alt_phone_type
      t.string :email

      # Notifications
      t.boolean :receive_emails, default: true
      t.boolean :receive_sms, default: true
      t.boolean :receive_postal_mail, default: true
      t.boolean :receive_grade_notices, default: true
      t.boolean :receive_conduct_notices, default: true

      # Permissions
      t.boolean :restricted, default: false # Guardian not able to interact with child or their records
    
      # Armed Services
      t.string :armed_service_branch
      t.string :armed_service_rank
      t.string :armed_service_duty_station

      
      t.boolean  :active, default: false
      t.string   :relationship
      t.boolean  :lives_with_student
      t.boolean  :has_custody
    end
  end
end