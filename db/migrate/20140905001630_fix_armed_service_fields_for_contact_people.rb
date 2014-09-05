class FixArmedServiceFieldsForContactPeople < ActiveRecord::Migration
  def change
    remove_column :contact_people, :armed_service_branch
    remove_column :contact_people, :armed_service_rank
    remove_column :contact_people, :armed_service_duty_station
    add_column :contact_people, :armed_service_status, :string
  end
end
