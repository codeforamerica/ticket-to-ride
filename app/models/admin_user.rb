# encoding: utf-8

class AdminUser < ActiveRecord::Base
  include ModelConstants

  # -- Relationships --
  belongs_to :district

  # -- Enumerations --
  enum user_role: [:central_admin, :district_admin]

  # -- Validations --

  # Names can only be letters, spaces, and dashes
  validates :name, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                   message: 'Name can only have letters, spaces, and dashes',
                                   allow_nil: true
  }

  validates :email, format: { with: ModelConstants::EMAIL_REGEX,
                              message: 'E-mail address was not valid',
                              allow_nil: true
  }
end
