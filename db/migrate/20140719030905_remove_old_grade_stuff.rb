class RemoveOldGradeStuff < ActiveRecord::Migration
  def change
    remove_column :students, :grade
    remove_column :students, :last_completed_grade
  end
end
