class AddGuardianFlagToContactPeople < ActiveRecord::Migration
  def change
    add_column :contact_people, :is_guardian, :boolean
  end
end
