class AddStudentAltHomeState < ActiveRecord::Migration
  def change
    add_column :students, :alt_home_state, :string
  end
end
