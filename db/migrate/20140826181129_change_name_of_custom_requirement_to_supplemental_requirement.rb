class ChangeNameOfCustomRequirementToSupplementalRequirement < ActiveRecord::Migration
  def change
    rename_table :custom_requirements, :supplemental_requirements
  end
end
