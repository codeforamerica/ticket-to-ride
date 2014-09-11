class AddBringDocumentationToSupplementalMaterials < ActiveRecord::Migration
  def change
    add_column :supplemental_materials, :bring_documentation, :boolean
  end
end
