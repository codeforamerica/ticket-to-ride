class StudentRace < ActiveRecord::Base
  belongs_to :student
  belongs_to :race
end
