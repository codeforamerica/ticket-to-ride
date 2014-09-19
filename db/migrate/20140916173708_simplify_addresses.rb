class SimplifyAddresses < ActiveRecord::Migration
  def change
    # Contact people
    rename_column :contact_people, :home_street_address_1, :street_address_1
    rename_column :contact_people, :home_street_address_2, :street_address_2
    rename_column :contact_people, :home_city, :city
    rename_column :contact_people, :home_state, :state
    rename_column :contact_people, :home_zip_code, :zip_code
    
    remove_column :contact_people, :mailing_street_address_1
    remove_column :contact_people, :mailing_street_address_2
    remove_column :contact_people, :mailing_state
    remove_column :contact_people, :mailing_city
    remove_column :contact_people, :mailing_zip_code
    
    # Students
    rename_column :students, :home_street_address_1, :street_address_1
    rename_column :students, :home_street_address_2, :street_address_2
    rename_column :students, :home_city, :city
    rename_column :students, :home_state, :state
    rename_column :students, :home_zip_code, :zip_code

    remove_column :students, :mailing_street_address_1
    remove_column :students, :mailing_street_address_2
    remove_column :students, :mailing_state
    remove_column :students, :mailing_city
    remove_column :students, :mailing_zip_code    
  end
end
