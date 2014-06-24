class RemoveEnrollmentDates < ActiveRecord::Migration
  def change
    remove_column :students, :enrollment_date
    remove_column :students, :enrollment_confirm_date
  end
end
