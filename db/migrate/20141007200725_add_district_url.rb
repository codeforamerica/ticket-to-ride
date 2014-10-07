class AddDistrictUrl < ActiveRecord::Migration
  def change
    add_column :districts, :url, :string
  end
end
