class StudentRace < ActiveRecord::Base
  belongs_to :student
  enum race: [:native_american, :asian, :white, :black, :pacific_islander]
end
