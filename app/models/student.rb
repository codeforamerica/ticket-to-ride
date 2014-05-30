class Student < ActiveRecord::Base
  has_many :guardians
  belongs_to :school
  acts_as_birthday :birthday
  enum gender: [:male, :female]
end