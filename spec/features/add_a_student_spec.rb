require 'spec_helper'

feature "Add a student" do 

  before(:all) do
    @student = create(:student)
  end

  scenario "When parent registers a student" do

    visit 'enrollment'
    
    # enrollment/student_name
    expect(current_path).to eq('/enrollment/student_name')
    expect(page).to have_content("To begin, click above the first blue dotted line and start typing.")
  end

  after(:all) do
    @student.destroy
  end
  
end