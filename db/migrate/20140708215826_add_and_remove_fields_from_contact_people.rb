class AddAndRemoveFieldsFromContactPeople < ActiveRecord::Migration
  def change
    add_column :contact_people, :middle_name, :string
    add_column :contact_people, :home_language, :string
    add_column :contact_people, :guardian_language, :string
    add_column :contact_people, :had_english_instruction, :boolean
    remove_column :contact_people, :phone
    remove_column :contact_people, :guardian_id
    add_column :contact_people, :receive_grade_notices, :boolean, default: false
    add_column :contact_people, :receive_conduct_notices, :boolean, default: false
    add_column :contact_people, :receive_other_mail, :boolean, default: true
    add_column :contact_people, :restricted, :boolean, default: false
    add_column :contact_people, :armed_service_branch, :string
    add_column :contact_people, :armed_service_rank, :string
    add_column :contact_people, :armed_service_duty_station, :string
    add_column :contact_people, :lives_with_student, :boolean, default: false
    add_column :contact_people, :has_custody, :boolean, default: false 
  end
end