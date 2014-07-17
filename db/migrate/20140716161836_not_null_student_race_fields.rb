class NotNullStudentRaceFields < ActiveRecord::Migration
  def change
    change_column_null :student_races, :student_id, false
    change_column_null :student_races, :race_id, false
  end
end
