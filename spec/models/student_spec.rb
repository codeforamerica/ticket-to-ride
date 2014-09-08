# spec/models/student
require 'spec_helper'

describe Student do 
  it "has a valid factory" do
    create(:student).should be_valid
  end
  it "is invalid with a first name composed of something other than letters" do 
    build(:student, first_name: "Mo11y").should_not be_valid
  end
  it "is invalid with a last name composed of something other than letters" do
    build(:student, last_name: "Sm!th").should_not be_valid
  end
  it "returns a student's full name as a string" do
    student = create(:student, first_name: "Thom", last_name: "Guertin")
    student.name.should == "Thom Guertin"
  end
  it "is invalid if student is older than 21" do
    build(:student, birthday: "1970-12-01")
  end
  it "is invalid if student is younger than 5" do 
    build(:student, birthday: "2010-12-01")
  end
end