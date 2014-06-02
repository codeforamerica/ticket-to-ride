class AddGuardianRelationship < ActiveRecord::Migration
  def change
    add_column :guardians, :relationship, :string
  end
end
