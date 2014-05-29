class AddCityToStudentDistrictSchoolAndGuardian < ActiveRecord::Migration
  def change
    # student
    add_column :students, :home_city, :string
    add_column :students, :mailing_city, :string

    # district
    add_column :districts, :mailing_city, :string

    # school
    add_column :schools, :mailing_city, :string

    # guardian
    add_column :guardians, :mailing_city, :string
  end
end
