module ContactPersonParams
  def contact_person_params
    params.require(:contact_person).permit(
      :relationship,
      :language,
      :mailing_street_address_1,
      :mailing_street_address_2,
      :mailing_zip_code,
      :phone,
      :can_pickup_child,
      :mailing_city,
      :mailing_state,
      :first_name,
      :last_name
    )
  end
end