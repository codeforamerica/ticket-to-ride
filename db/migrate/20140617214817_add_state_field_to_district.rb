class AddStateFieldToDistrict < ActiveRecord::Migration
  def change
    add_column :districts, :mailing_state, :string
  end
end
