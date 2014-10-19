class ReviseDistrictMessaging < ActiveRecord::Migration
  def change
    add_column :districts, :welcome_title, :string
    add_column :districts, :welcomer_name, :string
    add_column :districts, :welcomer_title, :string
    add_column :districts, :confirmation_title, :string
    add_column :districts, :confirmation_next_steps_message, :string
  end
end