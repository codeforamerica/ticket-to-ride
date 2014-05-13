class Student < ActiveRecord::Base
    has_many :guardians
	  acts_as_birthday :birthday
end