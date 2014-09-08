class CleanupAfterPaperclip < ActiveRecord::Migration
  def change
    remove_column :supplemental_materials, :req_type
    rename_column :supplemental_materials, :uri, :link_url
  end
end
