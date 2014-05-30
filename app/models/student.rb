class Student < ActiveRecord::Base
  has_many :guardians
  has_many :student_races
  belongs_to :school
  acts_as_birthday :birthday
  enum gender: [:male, :female]
end