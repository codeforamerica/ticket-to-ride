module ContactPersonParams
  def contact_person_params
    params.require(:contact_person).permit(
      :relationship,
      :language,
      :can_pickup_child,
      :street_address_1,
      :street_address_2,
      :zip_code,
      :can_pickup_child,
      :city,
      :state,
      :first_name,
      :last_name,
      :middle_name,
      :email,
      :receive_grade_notices,
      :receive_conduct_notices,
      :receive_other_mail,
      :restricted,
      :armed_service_status,
      :lives_with_student,
      :has_custody,
      :has_court_order,
      :court_order_description,
      :student_id,
      :main_phone,
      :main_phone_extension,
      :main_phone_can_sms,
      :secondary_phone,
      :secondary_phone_extension,
      :secondary_phone_can_sms,
      :work_phone,
      :work_phone_extension,
      :work_phone_can_sms,
      :is_guardian
    )
  end
end