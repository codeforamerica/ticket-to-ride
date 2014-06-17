class AddStudentBirthCityAndState < ActiveRecord::Migration
  def change
    add_column :students, :birth_city, :string
    add_column :students, :birth_state, :string
  end
end