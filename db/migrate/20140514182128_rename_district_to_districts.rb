class RenameDistrictToDistricts < ActiveRecord::Migration
  def change
    rename_table :district, :districts
  end
end
