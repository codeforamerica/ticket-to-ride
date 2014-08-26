class District < ActiveRecord::Base
  has_many :schools
  has_many :welcome_messages
  has_many :admin_users
  has_many :supplemental_requirements
end
