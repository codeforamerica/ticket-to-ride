require 'student_params'
require 'student_race_params'
require 'contact_person_params'

class EnrollmentController < ApplicationController
  include Wicked::Wizard
  include StudentParams
  include StudentRaceParams
  include ContactPersonParams

  # TODO: Break these flows into separate Wicked Wizards (Example: student, guardian, etc.)
  steps :student_name,
        :student_birth_gender_and_ethnicity, 
        :student_language, 
        :student_previous_school,
        :student_special_services,
        :student_address, 
        :student_complete,
        :guardian_name_and_address,
        :guardian_phone_and_email, 
        :guardian_second_name_and_relationship,
        :guardian_second_address_and_contact_info, 
        :guardian_complete,
        :contact_person_1_contact_info, 
        :contact_person_2_contact_info,
        :permissions, 
        :enrollment_complete

  def show
    @allsteps = wizard_steps
    @current_step = step
    @student_start = :student_name
    @guardian_start = :guardian_name_and_address
    @contact_start = :contact_person_1_contact_info
    @permissions = :permissions
    
    begin
      @student = Student.find(session[:student_id])
      @guardian = ContactPerson.find(session[:guardian_id]) # TODO Placeholder for getting through UI
    rescue
      @student = Student.new
      @guardian = ContactPerson.create # TODO Placeholder for getting through UI
    end

    if session[:second_guardian_id]
      # @second_guardian = ContactPerson.find(session[:second_guardian_id])
    end

    if step == :guardian_phone_and_email

    end

    #Handle gender pronouns, but not for first step
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

    if step == :permissions
      contact_1 = ContactPerson.new(first_name: 'John')
      contact_2 = ContactPerson.new(first_name: 'Ginger')
      contact_3 = ContactPerson.new(first_name: 'Bambi')
      @all_contacts = [contact_1, contact_2, contact_3]

      # @all_contacts = ContactPerson.where(contact_person_id:@guardian.id)
      # @all_contacts << @guardian
      # @guardian_and_contacts = @all_contacts.reverse
    end

    render_wizard
  end

  ##
  # Where forms PUT to in the Wizard flow
  ##
  def update

    # Handle the first step creation
    if step == :student_name
      # @guardian = Guardian.create(guardian_params)
      @student = Student.create(student_params)

      # session[:guardian_id] = @guardian.id
      session[:student_id] = @student.id
    else
      # @guardian = Guardian.find(session[:guardian_id])
      @student = Student.find(session[:student_id])
    end

    if step == :guardian_name_and_address
      @guardian = ContactPerson.create(contact_person_params)
      session[:guardian_id] = @guardian.id
    else
      # @guardian = ContactPerson.find(session[:contact_person_id])
    end

    set_next_step = next_step

    case step
      when :student_birth_gender_and_ethnicity

        params[:student][:is_hispanic] = isIsntToBoolean(params[:student][:is_hispanic])
        # params[:student][:gender] = genderPronounToEnum(params[:student][:gender])

        # TODO: Enable this later after we convert this a non-X-Editable format
        # @student_race = StudentRace.create(student_race_params)
        # @student_race.student = @student
        # @student_race.save
      when :student_language
        if params[:student][:secondary_language] == "(No Other Language)"
          params[:student][:secondary_language] = nil
        end
      when :guardian_phone_and_email
        @guardian = ContactPerson.find(session[:guardian_id])
        if !session[:second_guardian_id]
          set_next_step = :guardian_complete
        end
      when :guardian_second_name_and_relationship
        if params[:contact_person][:first_name] != ''
          @second_guardian = ContactPerson.create(contact_person_params)
          @second_guardian.save
          session[:second_guardian_id] = @second_guardian.id
        else
          set_next_step = :guardian_second_address_and_contact_info
        end
      when :contact_person_1_contact_info, :contact_person_2_contact_info
        @contact_person = ContactPerson.create(contact_person_params)
        @contact_person.save
        session[:contact_person_1_id] = @contact_person.id

        # TODO: For final completion, set all linked records to active
    end

    if params[:student]
      @student.update_attributes(student_params)
      @student.save
    end

    if params[:guardian]
      @guardian.update_attributes(contact_person_params)
      @guardian.save
    end

    jump_to set_next_step
    render_wizard
  end

end