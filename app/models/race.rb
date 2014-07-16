class Race < ActiveRecord::Base
  has_many :students, through: :student_races
end
