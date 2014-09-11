module DistrictParams
  def district_params
    params.require(:district).permit(
      :name,
      :street_address_1,
      :street_address_2,
      :city,
      :state,
      :zip_code,
      :phone,
      :active,
      :welcome_message,
      :confirmation_message
    )
  end
end