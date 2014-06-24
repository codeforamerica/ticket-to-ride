class RemoveFromStudentApplicationId < ActiveRecord::Migration
  def change
    remove_column :students, :application_id
  end
end
