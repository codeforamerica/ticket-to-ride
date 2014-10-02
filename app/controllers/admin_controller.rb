require 'admin_user_params'
require 'supplemental_materials_param'
require 'district_params'
require 'student_params'
require 'student_race_params'
require 'contact_person_params'

class AdminController < ApplicationController
  include AdminUserParams
  include SupplementalMaterialParams
  include DistrictParams
  include StudentParams
  include StudentRaceParams
  include ContactPersonParams

  # -----------
  # Constants
  # -----------

  APPLICATIONS_PER_PAGE = 25

  # -----------
  # INDEX
  # -----------

  def index
    @admins = AdminUser.all

    # If there are no admins created, the app was just installed -- setup a central admin
    if @admins.none?
      return redirect_to action: :central_setup_welcome
    end

    return redirect_to action: :admin_login
  end

  # -----------
  # Helper Methods
  # TODO Move these elsewhere so that they can be reused
  # -----------

  def param_does_not_exist(model_const, field_const)
    return !params || !params[model_const] || !params[model_const][field_const] || params[model_const][field_const] == ''
  end

  # TODO this method might replace `param_does_not_exist`
  def missing_param(model_const, field_const, model_obj, error_msg)
    if !params || !params[model_const] || !params[model_const][field_const] || params[model_const][field_const] == ''
      model_obj.errors.add(field_const, error_msg)
    end
  end

  def retainValuesAndErrors(obj, param_updater)
    # Copy existing error messages
    error_messages = {}
    obj.errors.each do |field, message|
      error_messages[field] = message
    end

    # Do model validation on incoming arguments (this clears existing errror messages)
    obj.assign_attributes(param_updater)
    obj.valid?

    # Repopulate the old error messages
    error_messages.each do |field, message|
      obj.errors.add(field, message)
    end
  end

  def get_logged_in_admin
    # TODO error handling
    admin_id = session[:admin_user_id]
    admin_user = AdminUser.find(admin_id)
    return admin_user
  end

  def edit_supplemental_material(id)
    @admin = get_logged_in_admin

    if id
      @supplemental_material = SupplementalMaterial.find(id) # TODO Better error checking
    else
      @supplemental_material = SupplementalMaterial.new
    end

    # Check fields to see if they were filled in
    if param_does_not_exist(:supplemental_material, :name)
      @supplemental_material.errors.add(:name, 'Please enter a Name')
    end

    if param_does_not_exist(:supplemental_material, :description)
      @supplemental_material.errors.add(:description, 'Please enter a Description')
    end

    # TYPE OF SUPPLEMENTAL MATERIAL
    num_types = 0
    # Has type: file
    if !param_does_not_exist(:supplemental_material, :file)
      num_types += 1
    end
    # Has type: link
    if !param_does_not_exist(:supplemental_material, :link_url)
      num_types += 1
    end
    # Has type: bring doc
    if params && params[:supplemental_material] && params[:supplemental_material][:bring_documentation] && params[:supplemental_material][:bring_documentation] != '' && params[:supplemental_material][:bring_documentation] != 0 && params[:supplemental_material][:bring_documentation] != '0'
      num_types += 1
    end

    if param_does_not_exist(:supplemental_material, :is_required)
      @supplemental_material.errors.add(:is_required, 'Please indicate if the supplemental material is required or not.')
    end

    # Check for errors
    retainValuesAndErrors(@supplemental_material, supplemental_material_params)
    if @supplemental_material.errors.any?
      return render 'supplemental_materials_edit'
    end

    # Populate any other fields and save
    if param_exists(:supplemental_material, :file)
      @supplemental_material.link_url = nil
      @supplemental_material.bring_documentation = false
    elsif param_exists(:supplemental_material, :link_url)
      @supplemental_material.file = nil
      @supplemental_material.bring_documentation = false
    else
      @supplemental_material.file = nil
      @supplemental_material.link_url = nil
    end

    if @admin.district != nil
      @supplemental_material.district = @admin.district
      @supplemental_material.authority_level = :district
    else
      @supplemental_material.authority_level = :central
    end
    @supplemental_material.save # TODO more error checking on the save

    if @supplemental_material.district != nil
      return redirect_to action: 'district_supplemental_materials'
    end

    return redirect_to action: 'central_supplemental_materials'
  end

  def param_exists(model_const, field_const)
    return !param_does_not_exist(model_const, field_const)
  end

  # -----------
  # Central Admin Setup
  # -----------

  def central_setup_welcome
    @body_class = "admin-setup admin-setup-1"
    return render 'central_setup_welcome', layout: 'admin_setup'
  end

  def central_setup_info_get
    @admin = AdminUser.new
    @body_class = "admin-setup admin-setup-2"
    return render 'central_setup_info', layout: 'admin_setup'
  end

  def central_setup_info_post
    @admin = AdminUser.new(user_role: :central_admin)
    @body_class = "admin-setup admin-setup-2"

    # Were the fields filled out?
    if param_does_not_exist(:admin_user, :name)
      @admin.errors.add(:name, 'No name was entered')
    end

    if param_does_not_exist(:admin_user, :email)
      @admin.errors.add(:email, 'E-mail address was not entered')
    end

    if param_does_not_exist(:admin_user, :password)
      @admin.errors.add(:password, 'Password was not entered')
    end

    if param_does_not_exist(:admin_user, :confirm_password)
      @admin.errors.add(:confirm_password, 'The password confirmation was not entered')
    end

    # If there were any errors, send back the same page with error messages
    retainValuesAndErrors(@admin, admin_user_params)
    if @admin.errors.any?
      return render 'central_setup_info', layout: 'admin_setup'
    end

    # TODO Is there a better way to do this check using the model layer?
    if AdminUser.where(email: @admin.email).any?
      @admin.errors.add(:base, 'A user with this e-mail address already exists')
      return render action: 'central_setup_info', layout: 'admin_setup'
    end

    # Save the central admin
    @admin.active = true
    @admin.save
    session[:admin_user_id] = @admin.id

    return redirect_to action: :central_setup_confirm
  end

  def central_setup_confirm
    @body_class = "admin-setup admin-setup-3"
    render 'central_setup_confirm', layout: 'admin_setup'
  end

  # -----------
  # Central Admin Supplemental Materials
  # -----------

  def central_supplemental_materials
    @admin = get_logged_in_admin

    @supplemental_materials = SupplementalMaterial.where(authority_level: SupplementalMaterial.authority_levels[:central])
    @supplemental_materials_required = @supplemental_materials.where(is_required: true)
    @supplemental_materials_optional = @supplemental_materials.where(is_required: false)

    return render 'central_supplemental_materials'
  end

  def central_supplemental_materials_add_get
    @admin = get_logged_in_admin
    @title                 = 'Add a supplemental material'
    @button_title          = 'Add'

    @supplemental_material = SupplementalMaterial.new

    return render 'supplemental_materials_edit'
  end

  def central_supplemental_materials_add_post
    @admin = get_logged_in_admin
    @title                 = 'Add a supplemental material'
    @button_title          = 'Add'
    return edit_supplemental_material(nil)
  end

  def central_supplemental_materials_edit_get
    @admin = get_logged_in_admin
    @title                 = 'Edit supplemental material'
    @button_title          = 'Edit'
    @supplemental_material = SupplementalMaterial.find(params[:id])
    return render 'supplemental_materials_edit'
  end

  def central_supplemental_materials_edit_post
    @admin = get_logged_in_admin
    @title                 = 'Edit supplemental material'
    @button_title          = 'Edit'
    return edit_supplemental_material(params[:id])
  end

  def central_supplemental_materials_delete_get
    @admin = get_logged_in_admin
    @body_class = "supplemental-materials-delete"
    @supplemental_material = SupplementalMaterial.find(params[:id]) # TODO Better error checking
    return render 'supplemental_materials_delete'
  end

  def central_supplemental_materials_delete_post
    @admin = get_logged_in_admin
    @body_class = "supplemental-materials-delete"
    @supplemental_material = SupplementalMaterial.find(params[:id]) # TODO Better error checking
    @supplemental_material.delete # TODO more error checking
    return redirect_to action: 'central_supplemental_materials'
  end

  # -----------
  # Central Admin People
  # -----------

  def edit_a_person_as_central(id)
    @admin = get_logged_in_admin

    if id
      @person = AdminUser.find(id)
    else
      @person = AdminUser.new
    end

    # Check to see if all the fields were submitted
    if param_does_not_exist(:admin_user, :name)
      @person.errors.add(:name, 'Please enter a name')
    end

    if param_does_not_exist(:admin_user, :email)
      @person.errors.add(:email, 'Please enter an email address')
    end

    if (@person.user_role != 'central_admin')
      if !params || !params[:district]
        @person.errors.add(:base, 'Please enter a district name')
      end
      @district_name = params[:district] # populate this for re-display incase there are errors
    end

    # See if there is already someone with this e-mail address
    if !id && AdminUser.find_by(email: params[:admin_user][:email]) != nil
      @person.errors.add(:email, 'There is already a user with this email address')
    end

    # Apply the fields and do validations (and send back errors if there are any)
    retainValuesAndErrors(@person, admin_user_params)
    if @person.errors.any?
      return render 'central_people_edit'
    end

    # Create or add to a district
    if @person.user_role != 'central_admin'
      district = District.find_by(name: @district_name.downcase)
      if district == nil
        district = District.create(name: @district_name.downcase)
      end
      @person.district = district
      @person.user_role = :district_admin
    else
      @person.user_role = :central_admin
    end

    @person.save

    @people = AdminUser.all

    return redirect_to action: 'central_people'
  end

  def central_people
    @admin = get_logged_in_admin

    @people = AdminUser.all.where.not(id: @admin.id).order(:name)
    unless @people.any?
      return render 'central_people_none'
    end

    return render 'central_people'
  end

  def central_people_add_get
    # Display variables
    @body_class = 'people-new'
    @title = 'Add a district administrator'
    @button_title = 'Add'

    @admin = get_logged_in_admin
    @person = AdminUser.new
    @district_name = nil

    return render 'central_people_edit'
  end

  def central_people_add_post
    @body_class = 'people-new'
    @title = 'Add a district administrator'
    @button_title = 'Add'

    return edit_a_person_as_central(nil)
  end

  def central_people_edit_get
    @body_class = 'people-edit'
    @title = 'Edit district administrator'
    @button_title = 'Edit'

    @admin = get_logged_in_admin
    @person = AdminUser.find(params[:id]) # TODO add authority check here
    if @person.user_role != 'central_admin'
      @district_name = @person.district.name
    end

    return render 'central_people_edit'
  end

  def central_people_edit_post
    id = params[:id] # TODO add authority check here

    @body_class = 'people-edit'
    @title = 'Edit district administrator'
    @button_title = 'Edit'

    return edit_a_person_as_central(id)
  end

  def central_people_delete_get
    @admin = get_logged_in_admin
    @body_class = "people-delete"
    @person = AdminUser.find(params[:id]) # TODO add authority check here
    return render 'central_people_delete'
  end

  def central_people_delete_post
    @admin = get_logged_in_admin
    @body_class = "people-delete"
    @person = AdminUser.find(params[:id]) # TODO add authority check here

    district = @person.district

    @person.delete

    if district.admin_users.count == 0
      # TODO delete all the students from the district
      # students = district.students
      # students.delete

      district.delete
    end

    return redirect_to action: 'central_people'
  end

  # -----------
  # District Admin Setup
  # -----------
  def district_setup_get
    @admin = AdminUser.find(params[:admin_user_id]) # TODO error handling on bad ID
    @district = @admin.district
    return render 'district_setup', layout: 'admin_setup'
  end

  def district_setup_post
    @admin = AdminUser.find(params[:admin_user_id]) # TODO error handling on bad ID
    @district = @admin.district

    # Check to make sure parameters were entered
    if param_does_not_exist(:admin_user, :name)
      @admin.errors.add(:name, 'Please enter a name')
    end
    if param_does_not_exist(:admin_user, :email)
      @admin.errors.add(:email, 'Please enter an email address')
    end
    if param_does_not_exist(:admin_user, :password)
      @admin.errors.add(:base, 'Please enter a password') # TODO switch to actual password field
    end
    if param_does_not_exist(:admin_user, :confirm_password)
      @admin.errors.add(:base, 'Please confirm the password') # TODO switch to actual password field
    end
    if param_does_not_exist(:district, :street_address_1)
      @district.errors.add(:street_address_1, "Please enter the first line of the district's  address")
    end
    if param_does_not_exist(:district, :city)
      @district.errors.add(:city, "Please enter the district's city")
    end
    if param_does_not_exist(:district, :state)
      @district.errors.add(:state, "Please enter the district's  state")
    end
    if param_does_not_exist(:district, :zip_code)
      @district.errors.add(:zip_code, "Please enter the district's ZIP code")
    end

    # If there were any errors, send back the same page with error messages
    retainValuesAndErrors(@admin, admin_user_params)
    retainValuesAndErrors(@district, district_params)
    if @admin.errors.any? || @district.errors.any?
      return render 'district_setup', layout: 'admin_setup'
    end

    # Update the fields
    begin
      @admin.save!
      @district.save!
    rescue Exception
      @admin.errors.add(:base, 'Not your fault. Could not save record. Please contact the system administrator.')
      return render 'district_setup'
    end

    session[:admin_user_id] = @admin.id

    return redirect_to action: :district_applications
  end

  # -----------
  # District Admin Applications
  # -----------

  def show_district_applications(is_processed)
    @admin = AdminUser.find(session[:admin_user_id])
    @district = @admin.district
    @is_processed = is_processed

    # Get students for the admin's district that have completed registration, but not been processed
    @students = Student.where(district: @district).order(:guardian_complete_time)
    
    @students_processed = @students.where.not(export_time: nil).where.not(confirmation_code: nil)
    @students_unprocessed = @students.where(export_time: nil).where.not(confirmation_code: nil)

    if is_processed
      @students = @students_processed
    else
      @students = @students_unprocessed
    end
    @students = @students.where.not(confirmation_code: nil) # Only applications that have completely gone through the guardian flow


    # Determine which page of students to show
    @num_pages = @students.count / APPLICATIONS_PER_PAGE
    if @students.count % APPLICATIONS_PER_PAGE > 0
      @num_pages += 1
    end

    @page = 1
    if params[:page] && params[:page] != ''
      requested_page = params[:page].to_i

      if requested_page <= @num_pages
        @page = requested_page
      end
    end

    start_index = 0
    if @page > 1
      start_index = (APPLICATIONS_PER_PAGE * @page) - 1
    end
    @students = @students.slice(start_index, APPLICATIONS_PER_PAGE)

    return render 'district_applications'
  end

  def district_applications_unprocessed
    @body_class = 'applications'
    return show_district_applications(false)
  end

  def district_applications_processed
    @body_class = 'applications'
    return show_district_applications(true)
  end

  def generate_application_detail_select_options

    @previous_grade_options = []
    Grades::ALL.each do |grade|
      @previous_grade_options << [t("grade_#{grade}"), grade]
    end

    @armed_service_status_options = []
    ArmedServiceStatuses::ALL.each do |status|
      @armed_service_status_options << [t("armed_service_status_#{status}"), status ]
    end
  end

  def district_view_application(page)
    @admin = AdminUser.find(session[:admin_user_id])

    @student = Student.find(params[:student_id]) # TODO Better error checking
    if @student.district != @admin.district # TODO Better authorization checking
      return render 'unauthorized'
    end

    @guardians = []
    @student.contact_people.each do |c|
      if c.is_guardian
        @guardians << c
      end
    end

    @contact_people = []
    @student.contact_people.each do |c|
      unless c.is_guardian
        @contact_people << c
      end
    end

    generate_application_detail_select_options

    return render page
  end

  def district_application_detail_get
    return district_view_application('district_application_detail')
  end

  def district_application_edit_get
    return district_view_application('district_application_edit')
  end

  # TODO cleanup - move this somewhere more relevant
  def are_model_errors(model_list)
    model_list.each do |m|
      if m.errors.any?
        return true
      end
    end

    return false
  end


  def district_application_edit_post
    @admin = AdminUser.find(session[:admin_user_id]) # TODO security check
    @body_class = 'applications'
    @student = Student.find(params[:student_id]) # TODO error checking
    @are_errors = false

    # STUDENT FIELDS
    missing_param(:student, :first_name, @student, 'Student first name is required')
    missing_param(:student, :last_name, @student, 'Student last name is required')
    missing_param(:student, :birthday, @student, 'Student birthday is required')
    missing_param(:student, :birth_city, @student, 'Student birth city is required')
    missing_param(:student, :birth_state, @student, 'Student birth state is required')
    missing_param(:student, :birth_country, @student, 'Student birth country is required')
    missing_param(:student, :first_language, @student, 'Student first language is required')
    missing_param(:student, :home_language, @student, 'Student home language is required')
    missing_param(:student, :gender, @student, 'Student gender is required')

    if !params || !params['races'] || !params['races'].any?
      @student.errors.add(:base, 'At least one student race needs to be selected')
    end

    if params[:student] && params[:student][:prior_grade] && params[:student][:prior_grade] == Grades::NONE
      missing_param(:student, :prior_school_name, @student, 'Prior school name is required when a prior grade is entered')
      missing_param(:student, :prior_school_city, @student, 'Prior school city is required when a prior grade is entered')
      missing_param(:student, :prior_school_state, @student, 'Prior school state is required when a prior grade is entered')
    end

    # GUARDIAN #1 FIELDS
    guardian_1 = @student.contact_people[0]
    missing_contact_person_params(guardian_1, 0, 'Guardian #1')


    # GUARDIAN #2 FIELDS
    has_second_guardian = @student.contact_people[1].is_guardian
    if has_second_guardian
      guardian_2 = @student.contact_people[1]
      missing_contact_person_params(guardian_2, 1, 'Guardian #2')
    end

    # CONTACT PERSON #1 FIELDS
    if has_second_guardian
      contact_person_1_number = 2
    else
      contact_person_1_number = 1
    end
    contact_person_1 = @student.contact_people[contact_person_1_number]
    missing_contact_person_params(contact_person_1, contact_person_1_number, 'Contact Person #1')

    # CONTACT PERSON #2 FIELDS
    if has_second_guardian
      contact_person_2_number = 3
    else
      contact_person_2_number = 2
    end
    contact_person_2 = @student.contact_people[contact_person_2_number]
    missing_contact_person_params(contact_person_2, contact_person_2_number, 'Contact Person #2')

    # Do model validations
    retainValuesAndErrors(@student, student_params)

    @student.contact_people.each_with_index do |contact_person, index|
      params[:contact_person] = params["contact_person_#{index}"] # "artificially" fill param to ease use of assign_attributes
      retainValuesAndErrors(contact_person, contact_person_params)
    end
    params[:contact_person] = nil # Not used after this

    # Save if there are no errors
    if @student.errors.any? || are_model_errors(@student.contact_people) || are_model_errors(@student.student_races)
      generate_application_detail_select_options
      @are_errors = true
      return render 'district_application_edit'
    else
      # Add all races to student, but remove the existing ones first
      @student.student_races.each {|r| r.delete}

      params['races'].each do |race|
        begin
          StudentRace.create(race: race, student: @student )
        rescue
          @student.errors.add(:race, 'Could not assign race')
          generate_application_detail_select_options
          @are_errors = true
          return render 'district_application_edit'
        end
      end

      # Save contact people
      @student.contact_people.each {|contact_person| contact_person.save}

      # Save student
      @student.save # TODO error check here
      @student.reload # refreshes transitive values, like race and contact people
    end

    @was_saved = true
    return redirect_to "/admin/district/application/#{@student.id}"
  end

  def missing_contact_person_params(contact_person, contact_person_number, contact_person_title)
    missing_param("contact_person_#{contact_person_number}", :first_name, contact_person, "#{contact_person_title}'s first name is required")
    missing_param("contact_person_#{contact_person_number}", :last_name, contact_person, "#{contact_person_title}'s last name is required")
    missing_param("contact_person_#{contact_person_number}", :relationship, contact_person, "#{contact_person_title}'s relationship to student is required")
    missing_param("contact_person_#{contact_person_number}", :street_address_1, contact_person, "#{contact_person_title}'s  street address line 1 is required")
    missing_param("contact_person_#{contact_person_number}", :city, contact_person, "#{contact_person_title}'s  city is required")
    missing_param("contact_person_#{contact_person_number}", :state, contact_person, "#{contact_person_title}'s state is required")
    missing_param("contact_person_#{contact_person_number}", :zip_code, contact_person, "#{contact_person_title}'s ZIP code is required")
    missing_param("contact_person_#{contact_person_number}", :main_phone, contact_person, "#{contact_person_title}'s phone number is required")
  end


  def district_application_process_get
    @admin = get_logged_in_admin
    @body_class = "application-process"
    @student = Student.find(params[:student_id]) # TODO better error checking and auth

    central_required = SupplementalMaterial.where(authority_level: SupplementalMaterial.authority_levels[:central], is_required: true)
    central_optional = SupplementalMaterial.where(authority_level: SupplementalMaterial.authority_levels[:central], is_required: false)
    district_required = SupplementalMaterial.where(authority_level: SupplementalMaterial.authority_levels[:district], district: @student.district, is_required: true)
    district_optional = SupplementalMaterial.where(authority_level: SupplementalMaterial.authority_levels[:district], district: @student.district, is_required: false)

    @supplemental_materials_required = central_required.concat(district_required)
    @supplemental_materials_optional = central_optional.concat(district_optional)

    return render 'district_application_process'
  end

  def district_application_process_post
    @admin = get_logged_in_admin
    @body_class = "application-process"
    @student = Student.find(params[:student_id]) # TODO better error checking and auth

    @student.export_time = DateTime.now
    @student.save

    return redirect_to action: 'district_applications_unprocessed'
  end

  # -----------
  # District Admin - District info
  # -----------

  def district_info_get
    @body_class = 'district'
    @admin = get_logged_in_admin # TODO auth
    @district = @admin.district

    @saved = false
    return render 'district_info'
  end

  def district_info_post
    @body_class = 'district'
    @admin = get_logged_in_admin # TODO auth
    @district = @admin.district

    missing_param(:district, :welcome_message, @district, 'Please enter a welcome message')
    missing_param(:district, :confirmation_message, @district, 'Please enter a confirmation message')
    missing_param(:district, :street_address_1, @district, 'Please enter a street address (line 1)')
    missing_param(:district, :city, @district, 'Please enter a city')
    missing_param(:district, :state, @district, 'Please enter a state')
    missing_param(:district, :zip_code, @district, 'Please enter a ZIP code')

    retainValuesAndErrors(@district, district_params)

    unless @district.errors.any?
      @district.save # TODO more error checking here
      @saved = true
    end

    return render 'district_info'
  end

  # -----------
  # District Admin - Supplemental Materials
  # -----------

  def district_supplemental_materials
    @body_class = 'supplemental-materials'
    @admin = get_logged_in_admin
    district = @admin.district

    # Get materials based on required or not
    district_supplemental_materials = SupplementalMaterial.where(authority_level: SupplementalMaterial.authority_levels[:district], district: district)
    district_supplemental_materials_required = district_supplemental_materials.where(is_required: true)
    district_supplemental_materials_optional = district_supplemental_materials.where(is_required: false)

    # Central supplemental materials
    central_supplemental_materials = SupplementalMaterial.where(authority_level: SupplementalMaterial.authority_levels[:central])
    central_supplemental_materials_required = central_supplemental_materials.where(is_required: true)
    central_supplemental_materials_optional = central_supplemental_materials.where(is_required: false)

    # Sort by required or not
    @supplemental_materials = district_supplemental_materials + central_supplemental_materials
    @supplemental_materials_required = district_supplemental_materials_required + central_supplemental_materials_required
    @supplemental_materials_optional = district_supplemental_materials_optional + central_supplemental_materials_optional
    return render 'district_supplemental_materials'
  end

  def district_supplemental_materials_add_get
    @body_class            = 'supplemental-materials'
    @title                 = 'Add a supplemental material'
    @button_title          = 'Add'
    @admin                 = get_logged_in_admin
    @supplemental_material = SupplementalMaterial.new

    return render 'supplemental_materials_edit'
  end

  def district_supplemental_materials_add_post
    @admin = get_logged_in_admin
    @title                 = 'Add a supplemental material'
    @button_title          = 'Add'
    @body_class = 'supplemental-materials'
    return edit_supplemental_material(nil)
  end

  def district_supplemental_materials_edit_get
    @admin = get_logged_in_admin
    @body_class = 'supplemental-materials'
    @title                 = 'Edit supplemental material'
    @button_title          = 'Edit'
    @supplemental_material = SupplementalMaterial.find(params[:id])

    if @admin.district != @supplemental_material.district
      return render 'unauthorized'
    end

    return render 'supplemental_materials_edit'
  end

  def district_supplemental_materials_edit_post
    @admin = get_logged_in_admin
    @body_class = 'supplemental-materials'
    @title                 = 'Edit supplemental material'
    @button_title          = 'Edit'
    @supplemental_material = SupplementalMaterial.find(params[:id])

    if @admin.district != @supplemental_material.district
      return render 'unauthorized'
    end

    return edit_supplemental_material(params[:id])
  end

  def district_supplemental_materials_delete_get
    @admin = get_logged_in_admin
    @body_class = 'supplemental-materials-delete'
    @supplemental_material = SupplementalMaterial.find(params[:id]) # TODO Better error checking

    if @admin.district != @supplemental_material.district
      return render 'unauthorized'
    end

    return render 'supplemental_materials_delete'
  end

  def district_supplemental_materials_delete_post
    @admin = get_logged_in_admin
    @body_class = 'supplemental-materials'
    @supplemental_material = SupplementalMaterial.find(params[:id]) # TODO Better error checking

    if @admin.district != @supplemental_material.district
      return render 'unauthorized'
    end

    @supplemental_material.delete # TODO more error checking
    return redirect_to action: 'district_supplemental_materials'
  end

  # -----------
  # District admin - people
  # -----------

  def district_people
    @admin = get_logged_in_admin
    @body_class = 'people'
    district = @admin.district

    @people = AdminUser.where(district: district)

    # get all district admins, except current
    if @people.empty?
      return render 'district_people_none'
    end

    return render 'district_people'
  end

  def district_people_add_get
    @admin = get_logged_in_admin
    @body_class = 'people-new'
    @title = 'Add a district administrator'
    @button_title = 'Add'

    @person = AdminUser.new

    return render 'district_people_edit'
  end

  def district_people_add_post
    @admin = get_logged_in_admin
    @body_class = 'people-new'
    @title = 'Add a district administrator'
    @button_title = 'Add'

    return edit_a_person_as_district(nil)
  end

  def district_people_edit_get
    @admin = get_logged_in_admin
    @body_class = 'people-new'
    @title = 'Edit district administrator'
    @button_title = 'Edit'

    @person = AdminUser.find(params[:id])

    if @admin.district != @person.district
      return render 'unauthorized'
    end

    return render 'district_people_edit'
  end

  def district_people_edit_post
    @admin = get_logged_in_admin
    @body_class = 'people-new'
    @title = 'Edit district administrator'
    @button_title = 'Edit'

    @person = AdminUser.find(params[:id])

    if @admin.district != @person.district
      return render 'unauthorized'
    end

    return edit_a_person_as_district(@person.id)
  end

  def district_people_delete_get
    @admin = get_logged_in_admin
    @body_class = 'people-delete'
    @person = AdminUser.find(params[:id])

    if @admin.district != @person.district
      return render 'unauthorized'
    end

    return render 'district_people_delete'
  end

  def district_people_delete_post
    @admin = get_logged_in_admin
    @body_class = 'people'
    @person = AdminUser.find(params[:id])

    if @admin.district != @person.district
      return render 'unauthorized'
    end

    @person.delete # TODO error check

    return redirect_to action: 'district_people'
  end

  def edit_a_person_as_district(id)
    @admin = get_logged_in_admin
    @body_class = 'people'
    district = @admin.district

    if id
      @person = AdminUser.find(id)
    else
      @person = AdminUser.new
    end

    # Check to see if all the fields were submitted
    if param_does_not_exist(:admin_user, :name)
      @person.errors.add(:name, 'Please enter a name')
    end

    if param_does_not_exist(:admin_user, :email)
      @person.errors.add(:email, 'Please enter an email address')
    end

    # See if there is already someone with this e-mail address
    if !id && AdminUser.find_by(email: params[:admin_user][:email]) != nil
      @person.errors.add(:email, 'There is already a user with this email address')
    end

    # Apply the fields and do validations (and send back errors if there are any)
    retainValuesAndErrors(@person, admin_user_params)
    if @person.errors.any?
      return render 'central_people_edit'
    end

    @person.district = district
    @person.user_role = :district_admin
    @person.save

    @people = AdminUser.all

    return redirect_to action: 'district_people'
  end

  # -----------
  # District Admin - Export Settings
  # -----------

  def export_settings_get
    @admin = get_logged_in_admin
    @body_class = "export"
    @district = @admin.district
    # TODO - Add authorization code here

    @export_frequency_options = [['Twice Daily', :export_twice_daily], ['Daily', :export_daily], ['Never', :export_never]]

    return render 'district_export_settings'
  end

  def export_settings_post
    # TODO - Disable logging on password on send
    @admin = get_logged_in_admin
    @district = @admin.district
    @export_frequency_options = [['Twice Daily', :export_twice_daily], ['Daily', :export_daily], ['Never', :export_never]] # TODO - Move this to a common place

    # Check for missing params
    missing_param(:district, :export_frequency, @district, 'Export frequency must be entered')
    missing_param(:district, :sftp_url, @district, 'Server address must be entered')
    missing_param(:district, :sftp_username, @district, 'User name must be entered')
    missing_param(:district, :sftp_password, @district, 'Password must be entered')
    missing_param(:district, :sftp_password_confirm, @district, 'Confirm password must be entered')
    missing_param(:district, :sftp_path, @district, 'Server path must be entered')

    # Do validations
    # TODO make the default export frequency never

    password = params[:district][:sftp_password]
    password_confirm = params[:district][:sftp_password_confirm]
    if password && password_confirm && (password != password_confirm)
      @district.errors.add(:password, 'Password and password confirmation do not match')
    end

    retainValuesAndErrors(@district, district_params)
    if @district.errors.any?
      return render 'district_export_settings'
    end

    # Save

    @notice = 'Changes saved'
    return render 'district_export_settings'
  end

  def export_processed_now
    @admin = get_logged_in_admin
    @district = @admin.district
    @export_frequency_options = [['Twice Daily', :export_twice_daily], ['Daily', :export_daily], ['Never', :export_never]] # TODO - Move this to a common place
    @notice = 'Processed applications have been exported'


    return render 'district_export_settings'
  end

  # -----------
  # Authentication/Authorization
  # -----------
  def admin_login

    @errors = {}
    @admins = AdminUser.all

    # GET
    if request.method_symbol == :get
      return render 'admin_login', layout: 'admin_setup'
    end

    # POST
    email = params['email']
    if email == nil
      @errors[:email] = 'You must enter an e-mail address'
      return render 'admin_login'
    end
    # password = request.POST['password']
    # if password == nil
    #   @errors[:password] = 'You must enter a password'
    #   render 'admin_login'
    # end

    admin_user = AdminUser.find_by(email: email) #TODO better error handling
    if admin_user == nil
      @errors[:username] = 'Could not find a user with that e-mail address'
      return render 'admin_login', layout: 'admin_setup'
    end

    session[:admin_user_id] = admin_user.id

    # TODO some more error checking around the district ID
    if admin_user.user_role == 'district_admin'
      return redirect_to action: 'district_applications_unprocessed'
    end

    return redirect_to action: 'central_supplemental_materials'
  end

  def show
    page_id = request.filtered_parameters['id']
    return render page_id
  end

end
