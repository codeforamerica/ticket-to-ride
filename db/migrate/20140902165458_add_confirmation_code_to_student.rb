class AddConfirmationCodeToStudent < ActiveRecord::Migration
  def change
    add_column :students, :confirmation_code, :string
    add_index :students, :confirmation_code, unique: true
  end
end
