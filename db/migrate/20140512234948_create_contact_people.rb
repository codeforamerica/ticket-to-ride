class CreateContactPeople < ActiveRecord::Migration
  def change
    create_table :contact_people do |t|
        # Connection to 
        t.string :relationship
        t.string :language

        # Mailing info
        t.string :mailing_street_address_1
        t.string :mailing_street_address_2
        t.string :mailing_zip_code

        # Contact information
        t.string :phone

        # Permissions
        t.boolean :can_pickup_child, default: false
    end
  end
end
