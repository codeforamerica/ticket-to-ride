class MakeStudentRaceRaceIdString < ActiveRecord::Migration
  def change
    change_column :student_races, :race_id, :string
    rename_column :student_races, :race_id, :race
  end
end
