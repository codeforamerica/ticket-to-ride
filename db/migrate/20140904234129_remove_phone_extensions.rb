class RemovePhoneExtensions < ActiveRecord::Migration
  def change
    remove_column :contact_people, :main_phone_extension
    remove_column :contact_people, :secondary_phone_extension
    remove_column :contact_people, :work_phone_extension
  end
end
