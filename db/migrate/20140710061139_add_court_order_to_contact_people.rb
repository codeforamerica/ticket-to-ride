class AddCourtOrderToContactPeople < ActiveRecord::Migration
  def change
    add_column :contact_people, :has_court_order, :boolean, default: false
    add_column :contact_people, :court_order_description, :string
  end
end
