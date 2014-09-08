class AddAttachmentFileToSupplementalMaterials < ActiveRecord::Migration
  def self.up
    change_table :supplemental_materials do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :supplemental_materials, :file
  end
end
