class AssociateStudentToRace < ActiveRecord::Migration
  def change
    remove_column :student_races, :race
    add_column :student_races, :race_id, :integer
  end
end
