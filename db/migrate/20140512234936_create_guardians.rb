class CreateGuardians < ActiveRecord::Migration
  def change
    create_table :guardians do |t|
        # Name
        t.string :first_name, null: false
        t.string :middle_name, null: false
        t.string :last_name, null: false

        # Postal mail / residency info
        t.string :mailing_street_address_1, null: false
        t.string :mailing_street_address_2, null: false
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
    end
  end
end
