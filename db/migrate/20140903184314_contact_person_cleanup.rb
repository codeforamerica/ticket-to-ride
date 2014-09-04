class ContactPersonCleanup < ActiveRecord::Migration
  def change
    remove_column :contact_people, :language
    remove_column :contact_people, :middle_name
    remove_column :contact_people, :restricted
    remove_column :contact_people, :has_custody
    remove_column :contact_people, :has_court_order
  end
end
