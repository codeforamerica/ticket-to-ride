class RenameCustomRequirementTypeField < ActiveRecord::Migration
  def change
    rename_column :custom_requirements, :type, :req_type
  end
end
