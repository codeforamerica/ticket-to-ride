class CreateContactPeoplePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :contact_people_phone_numbers, id: false do |t|
      t.belongs_to :contact_person
      t.belongs_to :phone_number
    end
  end
end
