class AddStudentProcessedFlag < ActiveRecord::Migration
  def change
    add_column :students, :is_processed, :boolean, default: false
  end
end
