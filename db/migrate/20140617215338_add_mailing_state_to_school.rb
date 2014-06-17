class AddMailingStateToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :mailing_state, :string
  end
end
