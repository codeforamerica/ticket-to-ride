class FlattenPhoneInfoIntoContacts < ActiveRecord::Migration
  def change
    drop_table :phone_numbers
    drop_table :contact_people_phone_numbers

    add_column :contact_people, :main_phone, :string
    add_column :contact_people, :main_phone_extension, :string
    add_column :contact_people, :main_phone_can_sms, :boolean

    add_column :contact_people, :secondary_phone, :string
    add_column :contact_people, :secondary_phone_ext, :string
    add_column :contact_people, :secondary_phone_can_sms, :string

    add_column :contact_people, :work_phone, :string
    add_column :contact_people, :work_phone_extension, :string
    add_column :contact_people, :work_phone_can_sms, :string
  end
end
