class ContactPerson < ActiveRecord::Base
  has_and_belongs_to_many :phone_numbers
  belongs_to :student
end
