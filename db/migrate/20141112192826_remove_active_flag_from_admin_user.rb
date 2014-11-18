class RemoveActiveFlagFromAdminUser < ActiveRecord::Migration
  def change
    remove_column :admin_users, :active
  end
end
