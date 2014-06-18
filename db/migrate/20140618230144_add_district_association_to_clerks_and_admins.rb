class AddDistrictAssociationToClerksAndAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :district_id, :integer
    add_column :clerks, :district_id, :integer
  end
end
