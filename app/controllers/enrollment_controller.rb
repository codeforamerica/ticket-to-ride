require 'guardian_params'
require 'student_params'

class EnrollmentController < ApplicationController
  include Wicked::Wizard
  include StudentParams
  include GuardianParams

  steps :student_birth_gender_and_ethnicity

  def show
    @student = Student.find(session[:student_id])
    # @student.update!(student_params)

    @guardian = Guardian.find(session[:guardian_id])
    # @guardian.update!(guardian_params)

    case step

      # This is a unique case, where the `show` has to save something
      when :student_birth_gender_and_ethnicity

        @guardian.student_id = @student.id

    # this should work, but doesn't ... fix this, but until then, use manual hack around (manual assignment)
    #     @student.update_attributes(params[:student])
    #     @guardian.update_attributes(params[:guardian])

        @student.first_name = params[:student][:first_name]
        @student.last_name = params[:student][:last_name]
        @student.home_city = params[:student][:home_city]

        @guardian.first_name = params[:guardian][:first_name]
        @guardian.last_name = params[:guardian][:last_name]

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