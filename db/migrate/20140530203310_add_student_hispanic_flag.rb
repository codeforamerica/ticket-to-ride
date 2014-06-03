class AddStudentHispanicFlag < ActiveRecord::Migration
  def change
    add_column :students, :is_hispanic, :boolean
  end
end
