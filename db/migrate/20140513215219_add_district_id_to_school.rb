class AddDistrictIdToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :district_id, :integer
  end
end
