class AddStudentRacesIdToRaces < ActiveRecord::Migration
  def change
    add_column :races, :student_race_id, :integer
  end
end
