class AddHomeStateToStudent < ActiveRecord::Migration
  def change
    add_column :students, :home_state, :string
  end
end
