class UpdateSchoolAddressConstraints < ActiveRecord::Migration
  def change
    change_column_null :schools, :mailing_street_address_1, true
    change_column_null :schools, :mailing_street_address_2, true
    change_column_null :schools, :mailing_zip_code, true
    change_column_null :schools, :phone, true
  end
end
