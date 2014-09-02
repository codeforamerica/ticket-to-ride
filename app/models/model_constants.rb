# encoding: utf-8

module ModelConstants

  # Regular expressions
  LETTERS_SPACES_AND_DASHES_REGEX = /\A(\p{L}|\s|-)+\z/
  LETTERS_SPACES_AND_DASHES_OPTIONAL_REGEX = /\A(\p{L}|\s|-)*\z/
  LETTERS_NUMBERS_SPACES_AND_DASHES_REGEX = /\A(\p{L}|\d|\s|-)+\z/
  STREET_ADDRESS_REGEX = /\A[\p{L}#\d\s\.-]+\z/
  STREET_ADDRESS_OPTIONAL_REGEX = /\A[\p{L}#\d\s\.-]*\z/
  PHONE_NUMBER_REGEX = /\A\d{3}-?\d{3}-?\d{4}\z/
  PHONE_NUMBER_OPTIONAL_REGEX = /\A(\d{3}-?\d{3}-?\d{4})?\z/
  PHONE_EXTENSION_REGEX = /\A\d*\z/
  STATE_REGEX = /\A[a-z]{2}\z/i
  ZIP_CODE_REGEX = /\A\d{5}(-\d{4})?\z/

end