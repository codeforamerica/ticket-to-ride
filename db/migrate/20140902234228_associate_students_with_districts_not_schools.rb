class AssociateStudentsWithDistrictsNotSchools < ActiveRecord::Migration
  def change
    remove_column :students, :school_id
    add_column :students, :district_id, :integer
    drop_table :schools
  end
end
