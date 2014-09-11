class CleanDistrictFields < ActiveRecord::Migration
  def change
    remove_column :districts, :first_day_of_school
    rename_column :districts, :mailing_street_address_1, :street_address_1
    rename_column :districts, :mailing_street_address_2, :street_address_2
    rename_column :districts, :mailing_city, :city
    rename_column :districts, :mailing_state, :state
    rename_column :districts, :mailing_zip_code, :zip_code
  end
end
