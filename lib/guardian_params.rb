module GuardianParams
  def guardian_params
    params.require(:guardian).permit(
        :first_name,
        :middle_name,
        :last_name,
        :street_address_1,
        :street_address_2,
        :state,
        :city,
        :zip_code,
        :cell_phone,
        :alt_phone,
        :alt_phone_type,
        :email,
        :receive_emails,
        :receive_sms,
        :receive_postal_mail,
        :receive_grade_notices,
        :receive_conduct_notices,
        :armed_service_status,
        :student_id,
        :lives_with_student
  end
end