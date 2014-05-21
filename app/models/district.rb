class District < ActiveRecord::Base
    has_many :schools
    has_many :welcome_messages
end
