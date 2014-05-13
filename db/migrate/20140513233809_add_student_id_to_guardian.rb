class AddStudentIdToGuardian < ActiveRecord::Migration
  def change
    add_column :guardians, :student_id, :integer
  end
end
