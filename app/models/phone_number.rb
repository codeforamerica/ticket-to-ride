class PhoneNumber < ActiveRecord::Base
  has_and_belongs_to_many :contact_people
end
