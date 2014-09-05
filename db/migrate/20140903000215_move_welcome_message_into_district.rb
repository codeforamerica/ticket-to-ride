class MoveWelcomeMessageIntoDistrict < ActiveRecord::Migration
  def change
    drop_table :welcome_messages
    add_column :districts, :welcome_message, :string
    add_column :districts, :confirmation_message, :string
  end
end
