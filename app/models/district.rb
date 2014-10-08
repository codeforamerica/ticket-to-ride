require 'encryptor'

class District < ActiveRecord::Base
  has_many :admin_users
  has_many :supplemental_materials

  # -- Enumerations --
  enum export_frequency: [:export_twice_daily, :daily, :never ]

  # -- Validations --

  # District name
  validates :name, format: { with: ModelConstants::LETTERS_NUMBERS_SPACES_AND_DASHES_REGEX,
                            message: 'District name can only have letters, numbers, spaces, and dashes',
                            allow_nil: true
  }

  # District Mailing Address Validations
  validates :street_address_1, format: { with: ModelConstants::STREET_ADDRESS_REGEX,
                                              message: 'Street address 1 can only have letters, numbers, dashes, and periods',
                                              allow_nil: true
  }
  validates :street_address_2, format: { with: ModelConstants::STREET_ADDRESS_OPTIONAL_REGEX,
                                              message: 'Street address 2 can only have letters, numbers, dashes, and periods',
                                              allow_nil: true
  }
  validates :city, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                  message: 'City can only contain letters, spaces, and dashes',
                                  allow_nil: true
  }
  validates :state, format: { with: ModelConstants::STATE_REGEX,
                                   message: 'State can only contain two letters',
                                   allow_nil: true
  }
  validates :zip_code, format: { with: ModelConstants::ZIP_CODE_REGEX,
                                      message: 'Zip code can only contain digits and dashes (example: 20930)',
                                      allow_nil: true
  }

  # Phone
  validates :phone, format: { with: ModelConstants::PHONE_NUMBER_OPTIONAL_REGEX,
                                   message: 'Phone number can only have digits and dashes, and must be 10 digits',
                                   allow_nil: true
  }

  # Email
  validates_email_format_of :email, :message => 'E-mail address was not valid', allow_nil: true, allow_blank: true

  # SFTP fields

  validates :sftp_url, format: {with: /\Asftp:\/\/.+/,
                                message: 'Server address must start with "sftp://"',
                                allow_nil: true
  }

  # validates :sftp_url, format: {with: /[!@]?/,
  #                               message: 'Server address cannot contain @ symbols',
  #                               allow_nil: true
  # }

  validates :sftp_path, format: {with: /[!@:\|]/,
                                 message: 'Server path cannot have the following symbols: @, :, |',
                                 allow_nil: true
  }

  # District URL
  validates :url, format: {with: ModelConstants::LETTERS_NUMBERS_SPACES_AND_DASHES_REGEX,
                           message: 'URL can only have letters ',
                           allow_nil: true
  }

  # -- Handlers for Properties --
  def sftp_password
    Encryptor.decrypt(self.sftp_password_hash)
  end

  def sftp_password=(password)
    self.sftp_password_hash = Encryptor.encrypt(password)
  end

  def name=(new_name)
    write_attribute(:name, new_name)
    self.url = make_url(new_name)
  end

  def make_url(name)
    return name.gsub(/\s+/, '-').downcase
  end

end
