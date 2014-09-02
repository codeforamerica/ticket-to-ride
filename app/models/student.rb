# encoding: utf-8

class Student < ActiveRecord::Base
  include ModelConstants

  # Relationships
  has_many :student_races
  has_many :contact_people
  belongs_to :district

  # Behavior
  acts_as_birthday :birthday

  # --- Validations ---

  # Enum Validations
  enum gender: [:male, :female]

  # Names can only be letters, spaces, and dashes
  validates :first_name, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                   message: 'First name can only have letters, spaces, and dashes',
                                   allow_nil: true
  }
  validates :middle_name, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_OPTIONAL_REGEX,
                                    message: 'Middle name can only have letters, spaces, and dashes',
                                    allow_nil: true
  }
  validates :last_name, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                  message: 'Last name can only have letters, spaces, and dashes',
                                  allow_nil: true
  }

  # Birthday must indicate the student being age 5 to 21
  validates_date :birthday, between: [21.years.ago, 5.years.ago],
                 allow_nil: true,
                 on_or_before_message: 'Student must be older than 5 years of age',
                 on_or_after_message: 'Student must be younger than 21 years of age'

  # Birth place values can only be letters, spaces, and dashes
  validates :birth_city, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                   message: 'Birth city can only have letters, spaces, and dashes',
                                   allow_nil: true
  }
  validates :birth_state, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                    message: 'Birth state/province can only have letters, spaces, and dashes',
                                    allow_nil: true
  }
  validates :birth_country, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                      message: 'Birth country can only have letters, spaces, and dashes',
                                      allow_nil: true
  }

  # Validate languages
  validates :first_language, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                       message: 'First language can only contain letters, spaces, and dashes',
                                       allow_nil: true
  }
  validates :home_language, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                      message: 'Home language can only contain letters, spaces, and dashes',
                                      allow_nil: true
  }
  validates :guardian_language, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                          message: 'Guardian language can only contain letters, spaces, and dashes',
                                          allow_nil: true
  }

  # Prior school information
  validates :prior_school_name, format: { with: ModelConstants::LETTERS_NUMBERS_SPACES_AND_DASHES_REGEX,
                                       message: 'Prior school name can only contain letters, numbers, spaces, and dashes',
                                       allow_nil: true
  }
  validates :prior_school_city, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                      message: 'Prior school city can only contain letters, spaces, and dashes',
                                      allow_nil: true
  }
  validates :prior_school_state, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                          message: 'Prior school state can only contain letters, spaces, and dashes',
                                          allow_nil: true
  }

  # Student's home address
  validates :home_street_address_1, format: { with: ModelConstants::STREET_ADDRESS_REGEX,
                                              message: 'Home street address 1 can only have letters, numbers, dashes, and periods',
                                              allow_nil: true
  }
  validates :home_street_address_2, format: { with: ModelConstants::STREET_ADDRESS_OPTIONAL_REGEX,
                                              message: 'Home street address 2 can only have letters, numbers, dashes, and periods',
                                              allow_nil: true
  }
  validates :home_city, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                  message: 'Home city can only contain letters, spaces, and dashes',
                                  allow_nil: true
  }
  validates :home_state, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                   message: 'Home state can only contain letters, spaces, and dashes',
                                   allow_nil: true
  }
  validates :home_zip_code, format: { with: /\A\d{5}(-\d{4})?\z/,
                                   message: 'Zip code can only contain digits and dashes (example: 20930)',
                                   allow_nil: true
  }

end