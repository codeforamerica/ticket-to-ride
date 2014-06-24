class MakeMailingStreetAddress2OptionalInSchools < ActiveRecord::Migration
  def change
    change_column_null :schools, :mailing_street_address_2, true
  end
end
