class AssociateStudentToPreviousGrade < ActiveRecord::Migration
  def change
    add_column :students, :previous_grade_id, :integer
  end
end
