module ContactPersonParams
  def contact_person_params
    params.require(:contact_person).permit(
      :relationship,
      :language,
      :mailing_street_address_1,
      :mailing_street_address_2,
      :mailing_zip_code,
      :can_pickup_child,
      :mailing_city,
      :mailing_state,
      :first_name,
      :last_name,
      :middle_name,
      :email,
      :receive_grade_notices,
      :receive_conduct_notices,
      :receive_other_mail,
      :restricted,
      :armed_service_branch,
      :armed_service_rank,
      :armed_service_duty_station,
      :lives_with_student,
      :has_custody,
      :has_court_order,
      :court_order_description,
      :student_id
    )
  end
end