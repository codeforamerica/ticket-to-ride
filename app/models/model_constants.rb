module ModelConstants

  # Regular expressions
  LETTERS_SPACES_AND_DASHES_REGEX = /\A(\p{L}|\s|-)+\z/
  LETTERS_NUMBERS_SPACES_AND_DASHES_REGEX = /\A(\p{L}|\d|\s|-)+\z/
  STREET_ADDRESS_REGEX = /\A[\p{L}\d\s\.-]+\z/
  STREET_ADDRESS_OPTIONAL_REGEX = /\A[\p{L}\d\s\.-]*\z/

end