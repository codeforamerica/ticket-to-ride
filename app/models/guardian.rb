class Guardian < ActiveRecord::Base
    has_many :contact_persons
    has_one :student
end
