class ContactPerson < ActiveRecord::Base
  has_and_belongs_to_many :phone_numbers
  belongs_to :student

  # Name validations
  validates :first_name, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                   message: 'First name can only have letters, spaces, and dashes',
                                   allow_nil: true
  }
  validates :last_name, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                  message: 'Last name can only have letters, spaces, and dashes',
                                  allow_nil: true
  }
  
  # Address validation
  validates :mailing_street_address_1, format: { with: ModelConstants::STREET_ADDRESS_REGEX,
                                              message: 'Home street address 1 can only have letters, numbers, dashes, and periods',
                                              allow_nil: true
  }
  validates :mailing_street_address_2, format: { with: ModelConstants::STREET_ADDRESS_OPTIONAL_REGEX,
                                              message: 'Home street address 2 can only have letters, numbers, dashes, and periods',
                                              allow_nil: true
  }
  validates :mailing_city, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                  message: 'Home city can only contain letters, spaces, and dashes',
                                  allow_nil: true
  }
  validates :mailing_state, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                   message: 'Home state can only contain letters, spaces, and dashes',
                                   allow_nil: true
  }
  validates :mailing_zip_code, format: { with: /\A\d{5}(-\d{4})?\z/,
                                      message: 'Mailing zip can only contain digits and dashes (example: 23045)',
                                      allow_nil: true
  }

  # Relationship validation
  validates :relationship, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                        message: 'Relationship can only contain letters, spaces, and dashes',
                                        allow_nil: true
  }

  # Phone number validation
  validates :main_phone, format: { with: ModelConstants::PHONE_NUMBER_REGEX,
                                   message: 'Main phone number can only have digits and dashes, and must be 10 digits',
                                   allow_nil: true
  }
  validates :main_phone_extension, format: { with: ModelConstants::PHONE_EXTENSION_REGEX,
                                             message: 'Main phone extension can only have digits',
                                             allow_nil: true
  }

  validates :secondary_phone, format: { with: ModelConstants::PHONE_NUMBER_OPTIONAL_REGEX,
                                   message: 'Secondary phone number can only have digits and dashes, and must be 10 digits',
                                   allow_nil: true
  }
  validates :secondary_phone_extension, format: { with: ModelConstants::PHONE_EXTENSION_REGEX,
                                             message: 'Main phone extension can only have digits',
                                             allow_nil: true
  }

  validates :work_phone, format: { with: ModelConstants::PHONE_NUMBER_OPTIONAL_REGEX,
                                   message: 'Work phone number can only have digits and dashes, and must be 10 digits',
                                   allow_nil: true
  }
  validates :work_phone_extension, format: { with: ModelConstants::PHONE_EXTENSION_REGEX,
                                                message: 'Work phone extension can only have digits',
                                                allow_nil: true
  }

  validates :email, format: { with: ModelConstants::EMAIL_REGEX,
                                             message: 'E-mail address was not valid',
                                             allow_nil: true
  }
end
