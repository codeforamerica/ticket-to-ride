class RemoveCourtOrderDetails < ActiveRecord::Migration
  def change
    remove_column :contact_people, :court_order_description
  end
end
