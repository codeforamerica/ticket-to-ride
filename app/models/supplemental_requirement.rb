class SupplementalRequirement < ActiveRecord::Base
  belongs_to :district
  enum req_type: [:url, :file]
  enum authority_level: [:central, :district] #central: for all schools, district: only for a specific district
end
