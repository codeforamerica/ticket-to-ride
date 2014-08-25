class RemovePreviousGrade < ActiveRecord::Migration
  def change
    drop_table :previous_grades
    change_column :students, :previous_grade_id, :string
    rename_column :students, :previous_grade_id, :previous_grade
  end
end
