class AdminUser < ActiveRecord::Base
  belongs_to :district

  enum user_role: [:central_admin, :district_admin]
end
