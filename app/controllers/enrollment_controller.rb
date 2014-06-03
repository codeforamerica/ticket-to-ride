require 'guardian_params'
require 'student_params'
require 'student_race_params'
require 'contact_person_params'

class EnrollmentController < ApplicationController
  include Wicked::Wizard
  include StudentParams
  include GuardianParams
  include StudentRaceParams
  include ContactPersonParams

  # TODO: Break these flows into separate Wicked Wizards (Example: student, guardian, etc.)
  steps :student_birth_gender_and_ethnicity, :student_language, :student_address, :student_complete,
        :guardian_custody_and_address, :guardian_second_guardian_address, :guardian_first_guardian_contact_info, :guardian_second_guardian_contact_info, :guardian_complete,
        :contact_person_contact_info,
        :enrollment_complete


  def show
    @student = Student.find(session[:student_id])
    @guardian = Guardian.find(session[:guardian_id])

    if session[:second_guardian_id]
      @second_guardian = ContactPerson.find(session[:second_guardian_id])
    end

    case step

    # This is a unique case, where the `show` has to save something
    when :student_birth_gender_and_ethnicity

      # Skip saving if this step has already been completed...done to support the 'Previous' button
      if session[:first_step_completed]
        @guardian.student_id = @student.id
        @student.update_attributes(student_params)
        @guardian.update_attributes(guardian_params)

        if !@student.save || !@guardian.save
          redirect_to URI(request.referer).path
        end

        # This is here to support the navigation via the 'Previous' button
        session[:first_step_completed] = true
      end
    else
      @gender_pronoun = genderEnumToPronoun(@student.gender.to_enum)
      @gender_possessive_pronoun = genderEnumToPossessivePronoun(@student.gender.to_enum)
      @gender_objective_pronoun = genderEnumToObjectivePronoun(@student.gender.to_enum)
      @gender_possessive_adjective = genderEnumToPossessiveAdjective(@student.gender.to_enum)
    end

    render_wizard
  end

  def update
    @guardian = Guardian.find(session[:guardian_id])
    @student = Student.find(session[:student_id])
    set_next_step = next_step

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
      when :guardian_custody_and_address
        if params[:contact_person][:first_name] != ''
          @second_guardian = ContactPerson.create(contact_person_params)
          @second_guardian.guardian = @guardian
          @second_guardian.save
          session[:second_guardian_id] = @second_guardian.id
        else
          set_next_step = :guardian_first_guardian_contact_info
        end
      when :guardian_second_guardian_address
        @second_guardian = ContactPerson.find(session[:second_guardian_id])
        @second_guardian.update_attributes(contact_person_params)
        @second_guardian.save
    end

    if params[:student]
      @student.update_attributes(student_params)
      @student.save
    end

    if params[:guardian]
      @guardian.update_attributes(guardian_params)
      @guardian.save
    end

    jump_to set_next_step
    render_wizard
  end

end