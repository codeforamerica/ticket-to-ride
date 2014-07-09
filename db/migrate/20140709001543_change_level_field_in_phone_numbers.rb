class ChangeLevelFieldInPhoneNumbers < ActiveRecord::Migration
  def change
    remove_column :phone_numbers, :level, :string
    add_column :phone_numbers, :priority_level, :string
  end
end
