class SupplementalMaterial < ActiveRecord::Base
  belongs_to :district
  enum authority_level: [:central, :district] #central: for all schools, district: only for a specific district

  has_attached_file :file
  validates_attachment_content_type :file, :content_type => /\A.*\Z/
end
