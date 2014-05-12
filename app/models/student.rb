class Student < ActiveRecord::Base
	acts_as_birthday :birthday
end