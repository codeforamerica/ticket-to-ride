# spec/models/student
require 'spec_helper'

describe Student do 
  it "has a valid factory" do
    create(:student).should be_valid
  end
  it "is invalid with a first name composed of something other than letters" do 
    expect(Student.new(first_name: "Mol1y")).to be_invalid
  end
  it "is invalid with a last name composed of something other than letters" do
    expect(build(:student, last_name: "Sm!th")).to be_invalid
  end
  it "returns a student's full name as a string" do
    student = create(:student, first_name: "Thom", last_name: "Guertin")
    expect(student.name).to eq "Thom Guertin"
  end
  it "is invalid if student is older than 21" do
    expect(build(:student, birthday: "1970-12-01")).to be_invalid
  end
  it "is invalid if student is younger than 5" do 
    expect(build(:student, birthday: "2014-12-01")).to be_invalid
  end
  it "is valid if student is between 5 and 21 years old" do
    expect(build(:student, birthday: "2005-08-10")).to be_valid
  end
end