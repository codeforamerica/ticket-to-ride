class AddGradeLevelToStudent < ActiveRecord::Migration
  def change
    add_column :students, :grade, :integer
  end
end
