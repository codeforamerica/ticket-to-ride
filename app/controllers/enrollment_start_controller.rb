require 'student_params'
require 'guardian_params'

class EnrollmentStartController < ApplicationController

  def start
    @student = Student.new(student_params)
    @guardian = Guardian.new(guardian_params)

    if @student.save && @guardian.save
      session[:guardian_id] = @guardian.id
      session[:student_id] = @student.id
      render 'enrollment_start'
    end
  end

end
