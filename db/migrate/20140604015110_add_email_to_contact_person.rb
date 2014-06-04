class AddEmailToContactPerson < ActiveRecord::Migration
  def change
    add_column :contact_people, :email, :string
  end
end
