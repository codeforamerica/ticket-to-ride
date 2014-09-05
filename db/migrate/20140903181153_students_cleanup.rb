class StudentsCleanup < ActiveRecord::Migration
  def change
    remove_column :students, :school_start_date
    remove_column :students, :bus_required

    remove_column :students, :mailing_street_address_1
    remove_column :students, :mailing_street_address_2
    remove_column :students, :mailing_city
    remove_column :students, :mailing_state
    remove_column :students, :mailing_zip_code

    remove_column :students, :alt_home_street_address_1
    remove_column :students, :alt_home_street_address_2
    remove_column :students, :alt_home_city
    remove_column :students, :alt_home_state
    remove_column :students, :alt_home_zip_code
    remove_column :students, :nickname

    remove_column :students, :is_processed
    remove_column :students, :is_gifted
    remove_column :students, :guardian_language

    change_column :students, :export_time, :datetime, default: nil

  end
end
