class EnrollmentStarterController < ApplicationController

  def index
    @student = Student.new
    @guardian = Guardian.new

    if @student.save && @guardian.save
      session[:guardian_id] = @guardian.id
      session[:student_id] = @student.id
      render 'index'
    end
  end

end
