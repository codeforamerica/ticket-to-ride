# encoding: utf-8

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
  validates :state, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                              message: 'State can only contain letters, spaces, and dashes',
                              allow_nil: true
  }
  validates :zip_code, format: { with: /\A\d{5}(-\d{4})?\z/,
                                 message: 'Zip code can only contain digits and dashes (example: 20930)',
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

  validates :secondary_phone, format: { with: ModelConstants::PHONE_NUMBER_OPTIONAL_REGEX,
                                   message: 'Secondary phone number can only have digits and dashes, and must be 10 digits',
                                   allow_nil: true
  }

  validates :work_phone, format: { with: ModelConstants::PHONE_NUMBER_OPTIONAL_REGEX,
                                   message: 'Work phone number can only have digits and dashes, and must be 10 digits',
                                   allow_nil: true
  }


  validates_email_format_of :email, :message => 'E-mail address was not valid', allow_nil: true, allow_blank: true
  # validates :email, format: { with: ModelConstants::EMAIL_REGEX,
  #                                            message: 'E-mail address was not valid',
  #                                            allow_nil: true,
  #                                            allow_blank: true

  # }
end
