class School < ActiveRecord::Base
  has_many :students
  belongs_to :district
  belongs_to :lea, :primary_key => 'lea_code'
end
