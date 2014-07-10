class AddLastCompletedGradeToStudents < ActiveRecord::Migration
  def change
    add_column :students, :last_completed_grade, :integer
  end
end
