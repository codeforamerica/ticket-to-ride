require 'student_params'
require 'guardian_params'

class EnrollmentStartController < ApplicationController
  include StudentParams
  include GuardianParams

  def start
    @student = Student.new()
    @guardian = Guardian.new()

    if @student.save && @guardian.save
      session[:guardian_id] = @guardian.id
      session[:student_id] = @student.id
      render 'enrollment_start'
    end
  end

end
