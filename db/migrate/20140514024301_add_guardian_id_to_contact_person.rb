class AddGuardianIdToContactPerson < ActiveRecord::Migration
  def change
    add_column :contact_people, :guardian_id, :integer
  end
end
