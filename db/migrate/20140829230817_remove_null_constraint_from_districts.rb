class RemoveNullConstraintFromDistricts < ActiveRecord::Migration
  def change
    change_column_null :districts, :mailing_street_address_1, true
    change_column_null :districts, :mailing_zip_code, true
    change_column_null :districts, :phone, true
  end
end
