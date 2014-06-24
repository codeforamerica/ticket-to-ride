class AddDistrictName < ActiveRecord::Migration
  def change
    add_column :districts, :name, :string
  end
end
