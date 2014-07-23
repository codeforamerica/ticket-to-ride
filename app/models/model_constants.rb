# encoding: utf-8

module ModelConstants

  # Regular expressions
  LETTERS_SPACES_AND_DASHES_REGEX = /\A(\p{L}|\s|-)+\z/
  LETTERS_NUMBERS_SPACES_AND_DASHES_REGEX = /\A(\p{L}|\d|\s|-)+\z/
  STREET_ADDRESS_REGEX = /\A[\p{L}#\d\s\.-]+\z/
  STREET_ADDRESS_OPTIONAL_REGEX = /\A[\p{L}#\d\s\.-]*\z/
  PHONE_NUMBER_REGEX = /\A\d{3}-?\d{3}-?\d{4}\z/
  PHONE_NUMBER_OPTIONAL_REGEX = /\A(\d{3}-?\d{3}-?\d{4})?\z/
  PHONE_EXTENSION_REGEX = /\A\d*\z/
  EMAIL_REGEX = /\A(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z\d](?:[a-z\d-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z\d])?)?\z/ # from http://www.regular-expressions.info/email.html

end