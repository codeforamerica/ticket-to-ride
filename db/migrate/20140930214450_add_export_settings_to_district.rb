class AddExportSettingsToDistrict < ActiveRecord::Migration
  def change
    add_column :districts, :sftp_url, :string
    add_column :districts, :sftp_path, :string
    add_column :districts, :sftp_username, :string
    add_column :districts, :sftp_password_hash, :string
    add_column :districts, :export_frequency, :integer
  end
end
