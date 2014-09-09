# spec/factories/students.rb
require 'faker'

FactoryGirl.define do
  factory :student do 
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birthday "2006-10-29"
  end

  factory :contact_person do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    relationship "Mother"
    home_street_address_1 { Faker::Address.street_address }
    home_city { Faker::Address.city }
    home_state "RI"
    home_zip_code { Faker::Address.zip }
    main_phone "999-999-9999"
    main_phone_can_sms true
    is_guardian true
  end

  factory :enrollment do
    current_step :student_name
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birthday "2006-10-29"
  end


end