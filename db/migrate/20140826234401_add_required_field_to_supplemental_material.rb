class AddRequiredFieldToSupplementalMaterial < ActiveRecord::Migration
  def change
    add_column :supplemental_materials, :is_required, :boolean
  end
end
