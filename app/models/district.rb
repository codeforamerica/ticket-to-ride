class District < ActiveRecord::Base
  has_many :schools
  has_many :welcome_messages
  has_many :admins
  has_many :clerks
end
