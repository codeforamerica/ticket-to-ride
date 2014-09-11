class District < ActiveRecord::Base
  has_many :admin_users
  has_many :supplemental_materials

  # District Mailing Address Validations
  validates :street_address_1, format: { with: ModelConstants::STREET_ADDRESS_REGEX,
                                              message: 'Mailing street address 1 can only have letters, numbers, dashes, and periods',
                                              allow_nil: true
  }
  validates :street_address_2, format: { with: ModelConstants::STREET_ADDRESS_OPTIONAL_REGEX,
                                              message: 'Mailing street address 2 can only have letters, numbers, dashes, and periods',
                                              allow_nil: true
  }
  validates :city, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                  message: 'Mailing city can only contain letters, spaces, and dashes',
                                  allow_nil: true
  }
  validates :state, format: { with: ModelConstants::STATE_REGEX,
                                   message: 'Mailing state can only contain two letters',
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
end
