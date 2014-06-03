class AddContactPersonMailingCityAndState < ActiveRecord::Migration
  def change
    add_column :contact_people, :mailing_city, :string
    add_column :contact_people, :mailing_state, :string
  end
end
