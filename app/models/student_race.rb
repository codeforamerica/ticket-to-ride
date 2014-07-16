class StudentRace < ActiveRecord::Base
  has_many :students
  has_many :races
end
