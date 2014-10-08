class AddDistrictEmail < ActiveRecord::Migration
  def change
    add_column :districts, :email, :string
  end
end
