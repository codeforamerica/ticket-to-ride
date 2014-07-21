class RemoveDefaultsFromContactPeople < ActiveRecord::Migration
  def change
    change_column_default :contact_people, :can_pickup_child, nil
    change_column_default :contact_people, :receive_grade_notices, nil
    change_column_default :contact_people, :receive_conduct_notices, nil
    change_column_default :contact_people, :restricted, nil
    change_column_default :contact_people, :lives_with_student, nil
    change_column_default :contact_people, :receive_other_mail, nil
    change_column_default :contact_people, :has_court_order, nil
    change_column_default :contact_people, :has_custody, nil
  end
end
