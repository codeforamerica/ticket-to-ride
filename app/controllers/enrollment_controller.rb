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
  helper EnrollmentHelper

  # TODO: Break these flows into separate Wicked Wizards (Example: student, guardian, etc.)
  steps :student_and_guardian_names,
        :student_birth_gender_and_ethnicity, 
        :student_language, 
        :student_previous_school,
        :student_special_services,
        :student_address, 
        :student_complete,
        :guardian_custody_and_address, 
        :guardian_second_guardian_address, 
        :guardian_first_guardian_phone, 
        :guardian_first_guardian_email_and_contact_prefs, 
        :guardian_second_guardian_phone, 
        :guardian_second_guardian_email_and_contact_prefs, 
        :guardian_complete,
        :contact_person_1_contact_info, 
        :contact_person_2_contact_info,
        :enrollment_complete

  def show
    @allsteps = wizard_steps
    
    begin
      @student = Student.find(session[:student_id])
      @guardian = Guardian.find(session[:guardian_id])
    rescue
      @student = Student.new
      @guardian = Guardian.new
    end

    if session[:second_guardian_id]
      @second_guardian = ContactPerson.find(session[:second_guardian_id])
    end

    # Handle gender pronouns, but not for first step
    if step != :student_birth_gender_and_ethnicity
      @gender_pronoun = genderEnumToPronoun(@student.gender.to_enum)
      @gender_possessive_pronoun = genderEnumToPossessivePronoun(@student.gender.to_enum)
      @gender_objective_pronoun = genderEnumToObjectivePronoun(@student.gender.to_enum)
      @gender_possessive_adjective = genderEnumToPossessiveAdjective(@student.gender.to_enum)
    end

    # Handle contact person
    if step == :contact_person_2_contact_info
      @contact_person = ContactPerson.find(session[:contact_person_1_id])
    end

    render_wizard
  end

  ##
  # Where forms PUT to in the Wizard flow
  ##
  def update

    # Handle the first step creation
    if step == :student_and_guardian_names
      @guardian = Guardian.create(guardian_params)
      @student = Student.create(student_params)

      session[:guardian_id] = @guardian.id
      session[:student_id] = @student.id
    else
      @guardian = Guardian.find(session[:guardian_id])
      @student = Student.find(session[:student_id])
    end

    set_next_step = next_step

    case step
      when :student_birth_gender_and_ethnicity

        #temporarily disabling these lines while prototyping
        # params[:student][:is_hispanic] = isIsntToBoolean(params[:student][:is_hispanic])
        # params[:student][:gender] = genderPronounToEnum(params[:student][:gender])


        # TODO: Enable this later after we convert this a non-X-Editable format
        # @student_race = StudentRace.create(student_race_params)
        # @student_race.student = @student
        # @student_race.save
      when :student_language
        if params[:student][:secondary_language] == "(No Other Language)"
          params[:student][:secondary_language] = nil
        end
      when :student_previous_school  
      when :student_special_services
      when :guardian_custody_and_address
        if params[:contact_person][:first_name] != ''
          @second_guardian = ContactPerson.create(contact_person_params)
          @second_guardian.guardian = @guardian
          @second_guardian.save
          session[:second_guardian_id] = @second_guardian.id
        else
          set_next_step = :guardian_first_guardian_phone
        end
      when :guardian_first_guardian_email_and_contact_prefs
        if !session[:second_guardian_id]
          set_next_step = :guardian_complete
        end
      when :guardian_second_guardian_phone, :guardian_second_guardian_email_and_contact_prefs
        # TODO: Re-enable this
        # @second_guardian = ContactPerson.find(session[:second_guardian_id])
        # @second_guardian.update_attributes(contact_person_params)
        # @second_guardian.save
      when :contact_person_1_contact_info, :contact_person_2_contact_info
        @contact_person = ContactPerson.create(contact_person_params)
        @contact_person.guardian = @guardian
        @contact_person.save
        session[:contact_person_1_id] = @contact_person.id

        # TODO: For final completion, set all linked records to active
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