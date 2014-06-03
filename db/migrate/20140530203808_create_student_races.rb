class CreateStudentRaces < ActiveRecord::Migration
  def change
    create_table :student_races do |t|
      t.integer :student_id
      t.string :race
      t.boolean :active
      t.timestamps
    end
  end
end
