class CustomRequirement < ActiveRecord::Base
  belongs_to :district
  enum type: [:url, :file]
  enum authority_level: [:central, :district] #central: for all schools, district: only for a specific district
end
