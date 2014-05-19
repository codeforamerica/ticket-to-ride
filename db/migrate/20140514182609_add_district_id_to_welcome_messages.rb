class AddDistrictIdToWelcomeMessages < ActiveRecord::Migration
  def change
    add_column :welcome_messages, :district_id, :integer
  end
end
