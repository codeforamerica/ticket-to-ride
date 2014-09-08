# spec/factories/students.rb
require 'faker'

FactoryGirl.define do
  factory :student do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.birthday "2006-10-29"
  end
end