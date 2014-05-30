class AddGenderToStudent < ActiveRecord::Migration
  def change
    add_column :students, :gender, :integer
  end
end
