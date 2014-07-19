class CreatePreviousGrades < ActiveRecord::Migration
  def change
    create_table :previous_grades do |t|
      t.string :code, null: false
      t.integer :grade_level, null: false

      t.timestamps
    end
  end

end
