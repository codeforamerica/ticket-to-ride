class AddHomeAddresses < ActiveRecord::Migration
  def change
    add_column :contact_people, :home_street_address_1, :string
    add_column :contact_people, :home_street_address_2, :string
    add_column :contact_people, :home_city, :string
    add_column :contact_people, :home_state, :string
    add_column :contact_people, :home_zip_code, :string

    add_column :students, :mailing_street_address_1, :string
    add_column :students, :mailing_street_address_2, :string
    add_column :students, :mailing_city, :string
    add_column :students, :mailing_state, :string
    add_column :students, :mailing_zip_code, :string
  end
end
