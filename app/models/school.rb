class School < ActiveRecord::Base
  has_many :students
  belongs_to :district
end
