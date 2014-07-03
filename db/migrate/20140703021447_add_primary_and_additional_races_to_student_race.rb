class AddPrimaryAndAdditionalRacesToStudentRace < ActiveRecord::Migration
  def change
    remove_column :student_races, :race, :integer
    add_column :student_races, :primary_race, :integer
    add_column :student_races, :additional_races, :string
  end
end
