class ChangeAltPhoneToEnum < ActiveRecord::Migration
  def change
    remove_column :guardians, :alt_phone_type
    add_column :guardians, :alt_phone_type, :integer
  end
end
