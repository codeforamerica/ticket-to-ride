class AddStudentIdtoContactPeople < ActiveRecord::Migration
  def change
    add_column :contact_people, :student_id, :integer
  end
end
