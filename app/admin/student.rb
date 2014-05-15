ActiveAdmin.register Student do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  permit_params :lasid,
                :ssid,
                :application_id,
                :first_name,
                :middle_name,
                :last_name,
                :birthday,
                :first_language,
                :second_language,
                :enrollment_date,
                :enrollment_confirm_date,
                :school_start_date,
                :estimated_graduation_date,
                :iep,
                :p504,
                :bus_required,
                :birth_certificate_verified,
                :residency_verified,
                :lunch_provided,
                :home_street_address_1,
                :home_street_address_2,
                :home_zip_code,
                :mailing_street_address_1,
                :mailing_street_address_2,
                :mailing_zip_code,
                :school_id
end
