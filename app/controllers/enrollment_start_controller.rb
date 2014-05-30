class EnrollmentStartController < ApplicationController

  def start
    @student = Student.new
    @guardian = Guardian.new

    if @student.save && @guardian.save
      session[:guardian_id] = @guardian.id
      session[:student_id] = @student.id
      render 'enrollment_start'
    end
  end

end
