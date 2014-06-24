class AddMailingStateToStudent < ActiveRecord::Migration
  def change
    add_column :students, :mailing_state, :string
  end
end
