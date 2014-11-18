# encoding: utf-8

class AdminUser < ActiveRecord::Base
  include ModelConstants

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :validatable

  # -- Relationships --
  belongs_to :district

  # accepts_nested_attributes_for :district

  # -- Enumerations --
  enum user_role: [:central_admin, :district_admin]

  # -- Validations --

  # Names can only be letters, spaces, and dashes
  validates :name, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                   message: 'Name can only have letters, spaces, and dashes',
                                   allow_nil: true
  }

  validates_email_format_of :email, :message => 'E-mail address was not valid', allow_nil: true, allow_blank: true
end
