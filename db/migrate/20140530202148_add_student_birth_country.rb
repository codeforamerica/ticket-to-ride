class AddStudentBirthCountry < ActiveRecord::Migration
  def change
    add_column :students, :birth_country, :string
  end
end
