class Student < ActiveRecord::Base
  include ModelConstants

  # Relationships
  has_many :races, through: :student_races
  has_many :contact_people
  belongs_to :school

  # Behavior
  acts_as_birthday :birthday

  # --- Validations ---

  # Enum Validations
  enum gender: [:male, :female]
  enum grade: [:pre_kindergarten, :kindergarten, :grade_1, :grade_2, :grade_3, :grade_4, :grade_5, :grade_6, :grade_7, :grade_8, :grade_9, :grade_10, :grade_11, :grade_12]
  enum last_completed_grade: [:pre_k, :k, :first_grade, :second_grade, :third_grade, :fourth_grade, :fifth_grade, :sixth_grade, :seventh_grade, :eighth_grade, :freshman, :sophomore, :junior]

  # Names can only be letters, spaces, and dashes
  validates :first_name, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
                                   message: 'First name can only have letters, spaces, and dashes',
                                   allow_nil: true
  }
  validates :middle_name, format: { with: ModelConstants::LETTERS_SPACES_AND_DASHES_REGEX,
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

end