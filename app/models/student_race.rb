class StudentRace < ActiveRecord::Base
  belongs_to :student

  validates_inclusion_of :race, in: Races::ALL, message: 'Please choose from one of the defined options for race'
end
