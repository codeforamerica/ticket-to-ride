class CreateStudentsContactPeople < ActiveRecord::Migration
  def change
    create_table :students_contact_people do |t|
      t.belongs_to :student
      t.belongs_to :contact_person
    end
  end
end
