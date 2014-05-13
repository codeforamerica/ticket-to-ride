class School < ActiveRecord::Base
    has_many :students
    has_many :welcome_messages
end
