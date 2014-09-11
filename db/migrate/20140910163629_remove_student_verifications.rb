class RemoveStudentVerifications < ActiveRecord::Migration
  def change
    remove_column :students, :birth_certificate_verified
    remove_column :students, :residency_verified
    remove_column :students, :lunch_provided
  end
end
