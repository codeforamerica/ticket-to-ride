class AddMailingStateToGuardians < ActiveRecord::Migration
  def change
    add_column :guardians, :mailing_state, :string
  end
end
