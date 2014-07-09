class RemoveLeasFromSchools < ActiveRecord::Migration
  def up
    remove_column :schools, :level, :string
    remove_column :schools, :lea_code, :integer
  end

  def down
    add_column :schools, :level, :string
    add_column :schools, :lea_code, :integer
  end
end
