class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
        
        # School's contact information
        t.string :mailing_street_address_1, null: false
        t.string :mailing_street_address_2, null: false
        t.string :mailing_zip_code, null: false
        t.string :phone, null: false

        t.date :first_day_of_school # Default first day of the school year

    end
  end
end
