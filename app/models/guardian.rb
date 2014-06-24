class Guardian < ActiveRecord::Base
  has_many :contact_persons
  belongs_to :student
  enum alt_phone_type: [:work, :home, :cell]
end
