require 'student_params'
require 'student_race_params'
require 'contact_person_params'

class EnrollmentController < ApplicationController
  include Wicked::Wizard
  include StudentParams
  include StudentRaceParams
  include ContactPersonParams
  include EnrollmentHelper

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

  # ---------
  # SHOW
  # This is contains the logic used to prep variables for the
  # views based on the current step in the flow
  #
  def show

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

    case step
      when :guardian_name_and_address
        @guardian_1 = ContactPerson.create
        session[:guardian_1_id] = @guardian_1.id
      when :guardian_phone_and_email
        @guardian_1 = ContactPerson.find(session[:guardian_1_id])
      when :guardian_second_name_and_relationship
        @guardian_2 = ContactPerson.create
        session[:guardian_2_id] = @guardian_2.id
      when :guardian_second_address_and_contact_info
        @guardian_2 = ContactPerson.find(session[:guardian_2_id])
        @guardian_1 = ContactPerson.find(session[:guardian_1_id])
      when :contact_person_1_contact_info, :contact_person_2_contact_info
        @contact_person = ContactPerson.create
        session[:contact_person_id] = @contact_person.id
    end

    render_wizard
  end


  # ------
  # UPDATE
  # Saves form submissions and manages session variables
  #
  def update
    @student = Student.find(session[:student_id])

    case step
      # Student steps
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

      # Guardian steps
      when :guardian_name_and_address
        @guardian_1 = ContactPerson.find(session[:guardian_1_id]) # TODO - make a @contact_person variable
        return update_guardian_name_and_address(@student, @guardian_1)

      when :guardian_phone_and_email
        @guardian_1 = ContactPerson.find(session[:guardian_1_id]) # TODO - make a @contact_person variable
        return update_guardian_phone_and_email(@guardian_1)

      when :guardian_second_name_and_relationship
        @guardian_2 = ContactPerson.find(session[:guardian_2_id]) # TODO - make a @contact_person variable
        return update_guardian_second_name_and_relationship(@student, @guardian_2)
      when :guardian_second_address_and_contact_info
        @guardian_1 = ContactPerson.find(session[:guardian_1_id])
        @guardian_2 = ContactPerson.find(session[:guardian_2_id]) # TODO - make a @contact_person variable
        return update_guardian_second_address_and_contact_info(@guardian_2)

      # Contact Person steps
      when :contact_person_1_contact_info, :contact_person_2_contact_info
        @contact_person = ContactPerson.find(session[:contact_person_id])
        return update_contact_person_contact_info(@student, @contact_person)

      # Permissions
      when :permissions
        return update_permissions(@student)


      # Pass through steps
      when :student_complete, :guardian_complete, :enrollment_complete
        jump_to next_step
        return render_wizard
    end

    # set_next_step = next_step
    # jump_to set_next_step
    return render_wizard
  end

  # --- Helpers ---

  def param_does_not_exist(model_const, field_const)
    return !params || !params[model_const] || !params[model_const][field_const] || params[model_const][field_const] == ''
  end

  def retainValuesAndErrors(obj, param_updater)
    messages = obj.errors.messages.clone()
    obj.update_attributes(param_updater)
    messages.each do |k,v|
      v.each {|e| obj.errors.add(k,e)}
    end
  end

  # --- End Helpers ---

  def update_student_name(student)
    if !params[:student] # TODO: Move this into update() to avoid repeating
      student.errors[:base] = 'Please fill out the form before moving on.'
      return render_wizard
    end

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
      retainValuesAndErrors(student, student_params)
      return render_wizard
    end

    student.update_attributes(student_params)
    return render_wizard student
  end

  def update_student_gender_and_ethnicity(student)
    if !params[:student]
      student.errors[:base] = 'Please fill out the form before moving on.'
      return render_wizard
    end

    if !params || !params[:student] || !params[:student][:gender]
      student.errors.add(:gender, 'Gender is a required field')
    end
    if param_does_not_exist(:student, :is_hispanic)
      student.errors.add(:is_hispanic, 'Is Hispanic? is a required field')
    end
    if !params || !params['races'] || !params['races'].any?
      student.errors.add(:races, 'At least one race needs to be selected')
    end

    begin
      student.gender = params[:student][:gender]
    rescue
      student.errors.add(:gender, 'Gender must be either Female or Male')
    end

    if student.errors.size > 0
      retainValuesAndErrors(student, student_params)
      return render_wizard
    end


    # Add all races to student, but remove the existing ones first
    student.student_races.each {|r| r.delete}

    params['races'].each do |race|
      begin
          StudentRace.create(race: race, student: student )
      rescue
        student.errors.add(:race, 'Could not assign race')
        retainValuesAndErrors(student, student_params)
        return render_wizard
      end
    end

    # Save the student
    student.update_attributes(student_params)
    return render_wizard @student
  end

  def update_student_language(student)
    if !params[:student]
      student.errors[:base] = 'Please fill out the form before moving on.'
      return render_wizard
    end

    if param_does_not_exist(:student, :first_language)
      student.errors.add(:first_language, 'First language is a required field')
    end
    if param_does_not_exist(:student, :home_language)
      student.errors.add(:home_language, 'Home language is a required field')
    end

    if student.errors.size > 0
      retainValuesAndErrors(student, student_params)
      return render_wizard
    end

    # Save the student
    student.update_attributes(student_params)
    return render_wizard student
  end

  def update_student_previous_school(student)
    if !params[:student]
      student.errors[:base] = 'Please fill out the form before moving on.'
      return render_wizard
    end

    # Last completed grade
    if param_does_not_exist(:student, :previous_grade)
      student.errors.add(:previous_grade, 'Previous grade is a required field')
    end

    previous_grade = params[:student][:previous_grade]
    if !Grades::ALL.include?(previous_grade)
      student.errors.add(:previous_grade, 'Previous grade has an invalid value')
    end

    # Only request previous school information when prior schooling isn't equal to none
    if previous_grade !=  Grades::NONE
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

    elsif previous_grade != nil
      params[:student].delete(:prior_school_name)
      params[:student].delete(:prior_school_city)
      params[:student].delete(:prior_school_state)
    end

    student.previous_grade = previous_grade

    if student.errors.size > 0
      retainValuesAndErrors(student, student_params)
      return render_wizard
    end

    # Save the student
    student.update_attributes(student_params)
    return render_wizard student
  end

  def update_student_special_services(student)
    if !params[:student]
      student.errors[:base] = 'Please fill out the form before moving on.'
      return render_wizard
    end

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
      retainValuesAndErrors(student,student_params)
      return render_wizard
    end

    # Save the student
    student.update_attributes(student_params)
    return render_wizard student
  end

  def update_student_address(student)
    if !params[:student]
      student.errors[:base] = 'Please fill out the form before moving on.'
      return render_wizard
    end

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
      retainValuesAndErrors(student,student_params)
      return render_wizard
    end

    # TODO: Later have this fillable on the form
    student.home_state = 'RI'

    # Save the student
    student.update_attributes(student_params)
    return render_wizard student
  end

  def validate_contact_person_name(contact_person)
    if param_does_not_exist(:contact_person, :first_name)
      contact_person.errors.add(:first_name, 'First name is a required field')
    end

    if param_does_not_exist(:contact_person, :last_name)
      contact_person.errors.add(:last_name, 'Last name is a required field')
    end

    return contact_person
  end

  def validate_contact_person_name_and_relationship(contact_person)
    validate_contact_person_name(contact_person)

    if param_does_not_exist(:contact_person, :relationship)
      contact_person.errors.add(:relationship, 'Relationship is a required field')
    end

    return contact_person
  end

  def validate_contact_person_home_address(contact_person)
    if param_does_not_exist(:contact_person, :home_street_address_1)
      contact_person.errors.add(:home_street_address_1, 'Home street address is a required field')
    end

    if param_does_not_exist(:contact_person, :home_city)
      contact_person.errors.add(:home_city, 'Home city is a required field')
    end

    if param_does_not_exist(:contact_person, :home_state)
      contact_person.errors.add(:home_state, 'Home state is a required field')
    end

    if param_does_not_exist(:contact_person, :home_zip_code)
      contact_person.errors.add(:home_zip_code, 'Home ZIP code is a required field')
    end

    return contact_person
  end

  def validate_contact_person_phone(contact_person)
    if param_does_not_exist(:contact_person, :main_phone)
      contact_person.errors.add(:main_phone, 'Main phone is a required field')
    end
    if param_does_not_exist(:contact_person, :main_phone_can_sms)
      contact_person.errors.add(:main_phone, 'Can the main phone accept text messages?')
    end

    return contact_person
  end

  def save_contact_person(contact_person)
    if contact_person.errors.size > 0
      retainValuesAndErrors(contact_person, contact_person_params)
      return render_wizard
    end

    contact_person.update_attributes(contact_person_params)
    return render_wizard contact_person
  end

  def save_and_associate_contact_person(student, contact_person)
    if contact_person.errors.size > 0
      retainValuesAndErrors(contact_person, contact_person_params)
      return render_wizard
    end

    # Save the contact person
    contact_person.update_attributes(contact_person_params)
    # contact_person.save

    # Associate the guardian, save the student
    student.contact_people << contact_person
    return render_wizard student
  end

  def update_guardian_name_and_address(student, contact_person)
    if !params[:contact_person]
      contact_person.errors[:base] = 'Please fill out the form before moving on.'
      return render_wizard
    end

    validate_contact_person_name_and_relationship(contact_person)

    validate_contact_person_home_address(contact_person)

    contact_person.is_guardian = true

    return save_and_associate_contact_person(student, contact_person)
  end

  def update_guardian_phone_and_email(contact_person)
    if !params[:contact_person]
      contact_person.errors[:base] = 'Please fill out the form before moving on.'
      return render_wizard
    end

    validate_contact_person_phone(contact_person)

    return save_contact_person(contact_person)
  end

  def update_guardian_second_name_and_relationship(student, contact_person)
    if !params[:contact_person]
      contact_person.errors[:base] = 'Please fill out the form before moving on.'
      return render_wizard
    end

    if params['has_additional_guardian'] == "false"
      jump_to :guardian_complete
      return render_wizard
    end

    validate_contact_person_name_and_relationship(contact_person)

    contact_person.is_guardian = true

    return save_and_associate_contact_person(student, contact_person)
  end

  def update_guardian_second_address_and_contact_info(contact_person)
    if !params[:contact_person]
      contact_person.errors[:base] = 'Please fill out the form before moving on.'
      return render_wizard
    end

    validate_contact_person_home_address(contact_person)
    validate_contact_person_phone(contact_person)
    return save_contact_person(contact_person)
  end

  def update_contact_person_contact_info(student, contact_person)
    if !params[:contact_person]
      contact_person.errors[:base] = 'Please fill out the form before moving on.'
      return render_wizard
    end

    validate_contact_person_name(contact_person)
    validate_contact_person_phone(contact_person)
    return save_and_associate_contact_person(student, contact_person)
  end

  def update_permissions(student)
    if params['has_court_order'] == nil
      student.errors.add('has_court_order', 'Are there any court orders regarding ' + student.first_name + '?')
      return render_wizard
    end

    contact_people = student.contact_people
    contact_people.each_with_index do |contact, index|
      form_name = 'contact_person_' + index.to_s + '_'

      can_pickup = params[form_name + 'pickup']
      if can_pickup
        contact.can_pickup_child = true
      end

      can_receive_records = params[form_name + 'records']
      if can_receive_records
        contact.receive_grade_notices = true
        contact.receive_conduct_notices = true
      end

      contact.save #TODO - Error catch
    end

    return render_wizard student
  end

end