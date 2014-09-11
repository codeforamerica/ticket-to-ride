module DistrictParams
  def district_params
    params.require(:district).permit(
      :name,
      :mailing_street_address_1,
      :mailing_street_address_2,
      :mailing_city,
      :mailing_state,
      :mailing_zip_code,
      :phone,
      :first_day_of_school,
      :active,
      :welcome_message,
      :confirmation_message
    )
  end
end