class ChangeNameOfCustomRequirementToSupplementalMaterial < ActiveRecord::Migration
  def change
    rename_table :custom_requirements, :supplemental_materials
  end
end
