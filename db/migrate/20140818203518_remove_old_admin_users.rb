class RemoveOldAdminUsers < ActiveRecord::Migration
  def change
    drop_table :clerks
    drop_table :admins
    drop_table :central_admins
  end
end
