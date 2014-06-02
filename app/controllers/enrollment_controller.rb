require 'guardian_params'
require 'student_params'
require 'student_race_params'

class EnrollmentController < ApplicationController
  include Wicked::Wizard
  include StudentParams
  include GuardianParams
  include StudentRaceParams

  steps :student_birth_gender_and_ethnicity, :student_language, :student_address,
        :guardian_custody_and_address


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
      else
        @gender_pronoun = genderEnumToPronoun(@student.gender)
        @gender_possessive = genderEnumToPossessivePronoun(@student.gender)
        @gender_objective = genderEnumToObjectivePronoun(@student.gender)
    end

    render_wizard
  end

  def update
    @guardian = Guardian.find(session[:guardian_id])
    @student = Student.find(session[:student_id])

    case step
      when :student_birth_gender_and_ethnicity
        params[:student][:is_hispanic] = isIsntToBoolean(params[:student][:is_hispanic])
        params[:student][:gender] = genderPronounToEnum(params[:student][:gender])

        @student_race = StudentRace.create(student_race_params)
        @student_race.student = @student
        @student_race.save
      when :student_language
        if params[:student][:secondary_language] == "(No Other Language)"
          params[:student][:secondary_language] = nil
        end
    end

    @student.update_attributes(student_params)

    render_wizard @student
  end

end