class CreateAdminUsers < ActiveRecord::Migration
  def change
    create_table :admin_users do |t|
      t.string :name
      t.string :email, null: false, unique: true
      t.integer :user_role, null: false
      t.boolean :active, default: false
      t.integer :district_id, null: true

      t.timestamps
    end
  end
end
