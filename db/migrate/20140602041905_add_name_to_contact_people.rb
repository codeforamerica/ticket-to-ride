class AddNameToContactPeople < ActiveRecord::Migration
  def change
    add_column :contact_people, :first_name, :string
    add_column :contact_people, :last_name, :string
  end
end
