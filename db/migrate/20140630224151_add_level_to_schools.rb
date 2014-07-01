class AddLevelToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :level, :string
  end
end
