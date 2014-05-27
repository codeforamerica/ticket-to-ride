class RemoveNullConstraintsFromGuardiansAndStudents < ActiveRecord::Migration
  def change
    # Guardians
    change_column_null :guardians, :first_name, true
    change_column_null :guardians, :middle_name, true
    change_column_null :guardians, :last_name, true
    change_column_null :guardians, :mailing_street_address_1, true
    change_column_null :guardians, :mailing_street_address_2, true
    change_column_null :guardians, :mailing_zip_code, true

    # Students
    change_column_null :students, :first_name, true
    change_column_null :students, :last_name, true
    change_column_null :students, :birthday, true
    change_column_null :students, :home_street_address_1, true
    change_column_null :students, :home_street_address_2, true
    change_column_null :students, :home_zip_code, true
    change_column_null :students, :mailing_street_address_1, true
    change_column_null :students, :mailing_zip_code, true
  end
end
