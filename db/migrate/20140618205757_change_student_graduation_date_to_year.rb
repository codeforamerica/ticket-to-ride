class ChangeStudentGraduationDateToYear < ActiveRecord::Migration
  def change
    remove_column :students, :estimated_graduation_date
    add_column :students, :estimated_graduation_year, :integer
  end
end
