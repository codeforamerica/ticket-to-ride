class AddPreviousSchoolToStudents < ActiveRecord::Migration
  def change
    add_column :students, :prior_school_name, :string
    add_column :students, :prior_school_city, :string
    add_column :students, :prior_school_state, :string
  end
end
