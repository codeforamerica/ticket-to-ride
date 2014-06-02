class AddAltAddressToStudent < ActiveRecord::Migration
  def change
    add_column :students, :alt_home_street_address_1, :string
    add_column :students, :alt_home_street_address_2, :string
    add_column :students, :alt_home_city, :string
    add_column :students, :alt_home_zip_code, :string
  end
end
