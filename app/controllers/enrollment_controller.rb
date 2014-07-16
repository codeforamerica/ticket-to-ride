require 'student_params'
require 'student_race_params'
require 'contact_person_params'

class EnrollmentController < ApplicationController
  include Wicked::Wizard
  include StudentParams
  include StudentRaceParams
  include ContactPersonParams

  # This is the order in which the views get rendered
  steps :student_name,
        :student_gender_and_ethnicity, 
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
        :summary,
        :enrollment_complete

  # Variables for navigation
  STUDENT_START_STEP = :student_name
  GUARDIAN_START_STEP = :guardian_name_and_address
  CONTACT_START_STEP = :contact_person_1_contact_info
  PERMISSIONS_STEP = :permissions
  SUMMARY_STEP = :summary

  # Steps where student gender pronouns need to be rendered
  STUDENT_GENDER_PRONOUN_STEPS = [
      :student_language,
      :student_special_services
  ]

  # SHOW
  # This is contains the logic used to prep variables for the
  # views based on the current step in the flow
  def show
  # def old_show
    # Variables for navigation purposes
    @student_start = :student_name
    @guardian_start = :guardian_name_and_address
    @contact_start = :contact_person_1_contact_info
    @permissions = :permissions
    @summary = :summary

    begin
      @student = Student.find(session[:student_id])
    rescue
      @student = Student.new
    end

    begin
      @guardian = ContactPerson.find(session[:guardian_id]) # TODO Placeholder for getting through UI
    rescue
      @guardian = ContactPerson.create # TODO Placeholder for getting through UI
    end

    if session[:second_guardian_id]
      @second_guardian = ContactPerson.find(session[:second_guardian_id])
    else
      @second_guardian = ContactPerson.new
    end

    if step == :guardian_phone_and_email

    end

    #Handle gender pronouns, but not for first step
    if step != :student_gender_and_ethnicity
      @gender_pronoun = genderToPronoun(@student.gender)
      @gender_possessive_pronoun = genderToPossessivePronoun(@student.gender)
      @gender_objective_pronoun = genderToObjectivePronoun(@student.gender)
      @gender_possessive_adjective = genderToPossessiveAdjective(@student.gender)
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
  # def old_update
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
      when :student_gender_and_ethnicity

        params[:student][:is_hispanic] = isIsntToBoolean(params[:student][:is_hispanic])

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
          if @second_guardian.first_name = ''
            set_next_step = :guardian_complete
          end
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


  # -------------------------------------------------------------------------------------------------------------------------
  # ------ In process of replace the show() and update() ... putting here since merging has been rough with this file -------
  #        These methods are not currently in use by default in the committed copy. Will remove old
  #        methods after they're fully functional.

  # ---------
  # SHOW
  # This is contains the logic used to prep variables for the
  # views based on the current step in the flow
  #
  def new_show

    # Clear the session on the first step, otherwise, load the Student
    if step == steps[0]
      reset_session
      @student = Student.create
      session[:student_id] = @student.id
    else
      @student = session[:student_id]
    end

    # Render student gender pronouns
    if STUDENT_GENDER_PRONOUN_STEPS.include?(step)
      @student_gender_pronoun = genderToPronoun(@student.gender) # He/She
      @student_gender_possessive_pronoun = genderToPossessivePronoun(@student.gender) # His/Hers
      @student_gender_objective_pronoun = genderToObjectivePronoun(@student.gender) # Him/Her
      @student_gender_possessive_adjective = genderToPossessiveAdjective(@student.gender) # His/Her
    end

    render_wizard
  end


  # ------
  # UPDATE
  # Saves form submissions and manages session variables
  #
  def new_update

    @student = Student.find(session[:student_id])
    @student.update_attributes(student_params)

    @is_valid = @student.valid?

    # set_next_step = next_step
    # jump_to set_next_step
    render_wizard @student
  end

end