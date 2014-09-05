class MakeAdminEmailUnique < ActiveRecord::Migration
  def change
    add_index :admin_users, :email, unique: true
  end
end
