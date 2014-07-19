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

  # Temporary
  UPDATED_STEPS = [
      :student_name,
      :student_gender_and_ethnicity,
      :student_language,
      :student_previous_school,
      :student_special_services,
      :student_address
  ]

  # Grades, sorted by order
  GRADES_IN_ORDER = PreviousGrade.all.sort_by { |g| g.grade_level }

  # SHOW
  # This is contains the logic used to prep variables for the
  # views based on the current step in the flow
  def show

    if UPDATED_STEPS.include?(step)
      return new_show
    end

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

    if UPDATED_STEPS.include?(step)
      return new_update
    end

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
          @second_guardian.save(validate: false)
          session[:second_guardian_id] = @second_guardian.id
          if @second_guardian.first_name = ''
            set_next_step = :guardian_complete
          end
        else
          set_next_step = :guardian_second_address_and_contact_info
        end
      when :contact_person_1_contact_info, :contact_person_2_contact_info
        @contact_person = ContactPerson.create(contact_person_params)
        @contact_person.save(validate: false)
        session[:contact_person_1_id] = @contact_person.id

        # TODO: For final completion, set all linked records to active
    end

    if params[:student]
      @student.update_attributes(student_params)
      @student.save(validate: false)
    end

    if params[:guardian]
      @guardian.update_attributes(contact_person_params)
      @guardian.save(validate: false)
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
  # def show

    # Clear the session on the first step, otherwise, load the Student
    if step == steps[0]
      reset_session
      @student = Student.create
      session[:student_id] = @student.id
    else
      @student = Student.find(session[:student_id])
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

    case step
      # Student name and birthplace
      when :student_name
        return update_student_name(@student)

      # Student name and birth info
      when :student_gender_and_ethnicity
        return update_student_gender_and_ethnicity(@student)

      when :student_language
        return update_student_language(@student)

      when :student_previous_school
        return update_student_previous_school(@student)

      when :student_special_services
        return update_student_special_services(@student)

      when :student_address
        return update_student_address(@student)

    end


    # set_next_step = next_step
    # jump_to set_next_step
    return render_wizard
  end


  def param_does_not_exist(model_const, field_const)
    return !params || !params[model_const] || !params[model_const][field_const] || params[model_const][field_const] == ''
  end

  def update_student_name(student)
    if param_does_not_exist(:student, :first_name)
      student.errors.add(:first_name, 'First name is a required field')
    end
    if param_does_not_exist(:student, :last_name)
      student.errors.add(:last_name, 'Last name is a required field')
    end
    if param_does_not_exist(:student, :birthday)
      student.errors.add(:birthday, 'Birthday is a required field')
    end
    if param_does_not_exist(:student, :birth_city)
      student.errors.add(:birth_city, 'Birth city is a required field')
    end
    if param_does_not_exist(:student, :birth_state)
      student.errors.add(:birth_state, 'Birth state/province is a required field')
    end
    if param_does_not_exist(:student, :birth_country)
      student.errors.add(:birth_country, 'Birth country is a required field')
    end

    if student.errors.size > 0
      return render_wizard
    end

    student.update_attributes(student_params)
    return render_wizard student
  end


  def update_student_gender_and_ethnicity(student)
    if !params || !params[:student] || !params[:student][:gender]
      student.errors.add(:gender, 'Gender is a required field')
    end
    if param_does_not_exist(:student, :is_hispanic)
      student.errors.add(:is_hispanic, 'Is Hispanic? is a required field')
    end
    if param_does_not_exist(:student, :race_ids)
      student.errors.add(:race_ids, 'At least one race needs to be selected')
    end

    begin
      student.gender = params[:student][:gender]
    rescue
      student.errors.add(:gender, 'Gender must be either Female or Male')
    end

    if student.errors.size > 0
      return render_wizard
    end


    # Add all races to student
    params[:student][:race_ids].each do |race_id|
      begin
        StudentRace.create(race_id: race_id, student: @student )
      rescue
        student.errors.add(:race_ids, 'Could not assign race')
        return render_wizard
      end
    end

    # Save the student
    student.update_attributes(student_params)
    return render_wizard @student
  end

  def update_student_language(student)
    if param_does_not_exist(:student, :first_language)
      student.errors.add(:first_language, 'First language is a required field')
    end
    if param_does_not_exist(:student, :home_language)
      student.errors.add(:home_language, 'Home language is a required field')
    end
    if param_does_not_exist(:student, :guardian_language)
      student.errors.add(:guardian_language, 'Guardian language is a required field')
    end
    if param_does_not_exist(:student, :had_english_instruction)
      student.errors.add(:had_english_instruction, 'Has English Instruction is a required field')
    end

    if student.errors.size > 0
      return render_wizard
    end

    # Save the student
    student.update_attributes(student_params)
    return render_wizard student
  end

  def update_student_previous_school(student)

    # Last completed grade
    if param_does_not_exist(:student, :previous_grade_id)
      student.errors.add(:previous_grade, 'Previous grade is a required field')
    end

    previous_grade_id = params[:student][:previous_grade_id]
    previous_grade = nil
    if previous_grade_id
      begin
        previous_grade = PreviousGrade.find(previous_grade_id)
      rescue
        student.errors.add(:previous_grade, 'Previous grade has an invalid value')
      end
    end

    # Only request previous school information when prior schooling isn't equal to none
    if previous_grade && previous_grade.code != 'none'

      # Prior school name
      if param_does_not_exist(:student, :prior_school_name)
        student.errors.add(:prior_school_name, 'Prior school name must be filled in')
      end

      # Prior school city
      if param_does_not_exist(:student, :prior_school_city)
        student.errors.add(:prior_school_city, 'Prior school city must be filled in')
      end

      # Prior school state
      if param_does_not_exist(:student, :prior_school_state)
        student.errors.add(:prior_school_state, 'Prior school state must be filled in')
      end

    else
      params[:student].delete(:prior_school_name)
      params[:student].delete(:prior_school_city)
      params[:student].delete(:prior_school_state)
    end

    if student.errors.size > 0
      return render_wizard
    end

    # Save the student
    student.update_attributes(student_params)
    student.previous_grade = previous_grade
    return render_wizard student
  end

  def update_student_special_services(student)

    if param_does_not_exist(:student, :needs_special_services)
      student.errors.add(:needs_special_services, 'Special services question must be answered')
    end

    if param_does_not_exist(:student, :iep)
      student.errors.add(:iep, 'IEP question must be answered')
    end

    if param_does_not_exist(:student, :p504)
      student.errors.add(:p504, '504 question must be answered')
    end

    if param_does_not_exist(:student, :has_learning_difficulties)
      student.errors.add(:has_learning_difficulties, 'Learning difficulties question must be answered')
    end

    if student.errors.size > 0
      return render_wizard
    end

    # Save the student
    student.update_attributes(student_params)
    return render_wizard student
  end

  def update_student_address(student)

    if param_does_not_exist(:student, :home_street_address_1)
      student.errors.add(:home_street_address_1, 'Home street address 1 is a required field')
    end
    if param_does_not_exist(:student, :home_city)
      student.errors.add(:home_city, 'Home city is a required field')
    end
    # if param_does_not_exist(:student, :home_state)
    #   student.errors.add(:home_state, 'Home state is a required field')
    # end
    if param_does_not_exist(:student, :home_zip_code)
      student.errors.add(:home_zip_code, 'Home zip code is a required field')
    end

    if student.errors.size > 0
      return render_wizard
    end

    # Save the student
    student.update_attributes(student_params)
    return render_wizard student
  end

end