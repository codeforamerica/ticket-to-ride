class School < ActiveRecord::Base
  has_many :students
  has_many :admin_users
  belongs_to :district
end
