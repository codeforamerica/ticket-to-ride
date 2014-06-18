class CreateCentralAdmins < ActiveRecord::Migration
  def change
    create_table :central_admins do |t|
      t.string :name
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
