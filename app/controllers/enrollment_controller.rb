require 'guardian_params'
require 'student_params'

class EnrollmentController < ApplicationController
  include Wicked::Wizard
  include StudentParams
  include GuardianParams

  steps :student_birth_gender_and_ethnicity, :student_language

  def show
    @student = Student.find(session[:student_id])
    @guardian = Guardian.find(session[:guardian_id])

    case step

    # This is a unique case, where the `show` has to save something
    when :student_birth_gender_and_ethnicity
      # @student.update!(student_params)
      @guardian.student_id = @student.id
      # @guardian.update!(guardian_params)

      @student.update_attributes(student_params)
      @guardian.update_attributes(guardian_params)

      if !@student.save || !@guardian.save
        redirect_to URI(request.referer).path
      end
    end

    render_wizard
  end

  def update
    @guardian = Guardian.find(session[:guardian_id])
    @student = Student.find(session[:student_id])



    render_wizard
  end

end