class ChangeStudentRaceValueToEnum < ActiveRecord::Migration
  def change
    remove_column :student_races, :race
    add_column :student_races, :race, :integer
  end
end
