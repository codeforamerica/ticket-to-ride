class RenameSchoolToDistrict < ActiveRecord::Migration
  def change
    rename_table :schools, :district
  end
end
