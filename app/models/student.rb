class Student < ActiveRecord::Base
    has_many :guardians
end