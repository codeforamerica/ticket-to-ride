class Race < ActiveRecord::Base
  has_many :student_races
  has_many :students, through: :student_races
end
