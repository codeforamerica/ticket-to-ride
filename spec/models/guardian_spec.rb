# spec/models/contact_person
require 'spec_helper'

describe ContactPerson do 
  it "has a valid factory" do
    create(:contact_person).should be_valid
  end
  it "is invalid with a first name composed of something other than letters" do 
    build(:contact_person, first_name: "Mo11y").should_not be_valid
  end
  it "is invalid with a last name composed of something other than letters" do
    build(:contact_person, last_name: "Sm!th").should_not be_valid
  end
  it "is invalid if home zipcode is composed of something other than numbers" do
    build(:contact_person, home_zip_code: "5ftt3s")
  end
end