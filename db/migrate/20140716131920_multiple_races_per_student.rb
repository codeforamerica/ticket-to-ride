class MultipleRacesPerStudent < ActiveRecord::Migration
  def change
    remove_column :student_races, :primary_race
    remove_column :student_races, :additional_races
    add_column :student_races, :race, :integer
  end
end
