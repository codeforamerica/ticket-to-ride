class AddLivingSituationToGuardians < ActiveRecord::Migration
  def change
    add_column :guardians, :lives_with_student, :boolean
  end
end
