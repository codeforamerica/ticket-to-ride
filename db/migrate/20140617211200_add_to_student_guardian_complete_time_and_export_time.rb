class AddToStudentGuardianCompleteTimeAndExportTime < ActiveRecord::Migration
  def change
    add_column :students, :guardian_complete_time, :datetime
    add_column :students, :export_time, :datetime
  end
end