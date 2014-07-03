class AddSpecialServicesToStudents < ActiveRecord::Migration
  def change
    add_column :students, :needs_special_services, :boolean
    add_column :students, :is_gifted, :boolean
    add_column :students, :has_learning_difficulties, :boolean
  end
end