class AddLeaCodeToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :lea_code, :integer
  end
end
