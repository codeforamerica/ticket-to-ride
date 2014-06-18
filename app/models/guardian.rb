class Guardian < ActiveRecord::Base
  has_many :contact_persons
  has_one :student
  enum alt_phone_type: [:work, :home, :cell]
end
