module GuardianParams
  def guardian_params
    params.require(:guardian).permit(
        :first_name,
        :middle_name,
        :last_name,
        :mailing_street_address_1,
        :mailing_street_address_2,
        :mailing_zip_code,
        :cell_phone,
        :alt_phone,
        :alt_phone_type,
        :email,
        :receive_emails,
        :receive_sms,
        :receive_postal_mail,
        :receive_grade_notices,
        :receive_conduct_notices,
        :restricted,
        :armed_service_branch,
        :armed_service_rank,
        :armed_service_duty_station,
        :student_id,
        :mailing_city
    )
  end
end