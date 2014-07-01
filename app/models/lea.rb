class Lea < ActiveRecord::Base
  has_many :schools, :foreign_key => 'lea_code'
end


