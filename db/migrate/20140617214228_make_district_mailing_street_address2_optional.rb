class MakeDistrictMailingStreetAddress2Optional < ActiveRecord::Migration
  def change
    change_column_null :districts, :mailing_street_address_2, true
  end
end
