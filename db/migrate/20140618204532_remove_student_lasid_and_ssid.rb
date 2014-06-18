class RemoveStudentLasidAndSsid < ActiveRecord::Migration
  def change
    remove_column :students, :lasid
    remove_column :students, :ssid
  end
end
