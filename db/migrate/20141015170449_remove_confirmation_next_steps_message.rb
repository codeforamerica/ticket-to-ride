class RemoveConfirmationNextStepsMessage < ActiveRecord::Migration
  def change
    remove_column :districts, :confirmation_next_steps_message
  end
end
