require 'admin_user_params'
require 'supplemental_materials_param'
require 'district_params'
require 'student_params'
require 'student_race_params'
require 'contact_person_params'
require 'securerandom' # For generating district admin temp passwords

class AdminController < ApplicationController
  include AdminUserParams
  include SupplementalMaterialParams
  include DistrictParams
  include StudentParams
  include StudentRaceParams
  include ContactPersonParams


  before_action :authenticate_admin_user!
  skip_before_action :authenticate_admin_user!,
                     only: [
                         :index,
                         :central_setup_welcome,
                         :central_setup_info_get,
                         :central_setup_info_post,
                         :central_setup_confirm,
                         :district_setup_get,
                         :district_setup_post,
                     ]

  before_action :is_admin_user_central,
                only: [
                    :central_supplemental_materials,
                    :central_supplemental_materials_add_get,
                    :central_supplemental_materials_add_post,
                    :central_supplemental_materials_edit_get,
                    :central_supplemental_materials_edit_post,
                    :central_supplemental_materials_delete_get,
                    :central_people,
                    :central_people_add_get,
                    :central_people_add_post,
                    :central_people_edit_get,
                    :central_people_edit_post,
                    :central_people_delete_get,
                    :central_people_delete_post
                ]

  before_action :is_admin_user_district,
                only: [
                    :district_applications_unprocessed,
                    :district_applications_processed,
                    :district_view_application,
                    :district_application_detail_get,
                    :district_application_edit_get,
                    :district_application_edit_post,
                    :district_application_process_get,
                    :district_application_process_post,
                    :district_info_get,
                    :district_info_post,
                    :district_supplemental_materials,
                    :district_supplemental_materials_add_get,
                    :district_supplemental_materials_add_post,
                    :district_supplemental_materials_edit_get,
                    :district_supplemental_materials_edit_post,
                    :district_supplemental_materials_delete_get,
                    :district_supplemental_materials_delete_post,
                    :district_people,
                    :district_people_add_get,
                    :district_people_add_post,
                    :district_people_edit_get,
                    :district_people_edit_post,
                    :district_people_delete_get,
                    :district_people_delete_post,
                    :export_settings_get,
                    :export_settings_post,
                    :export_processed_now
                ]

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

    return redirect_to action: :login
  end

  def login
    if is_admin_user_central?
      return redirect_to action: :central_supplemental_materials
    elsif is_admin_user_district?
      if current_admin_user.district.welcome_title == nil
        return redirect_to action: :district_info_get
      else
        return redirect_to action: :district_applications_unprocessed
      end
    end

    return redirect_to '/'
  end

  def signout
    reset_session
    return redirect_to action: :login
end

  # -----------
  # Helper Methods
  # TODO Move these elsewhere so that they can be reused
  # -----------

  def create_blank_district(name)
    district = District.create(name: @district_name)
    # district.welcome_title = "Welcome Title Goes Here"
    # district.welcome_message = "Welcome Message Goes Here"
    # district.welcomer_name = "Welcomer Name Goes Here"
    # district.welcomer_title = "Welcomer Title Goes Here"
    # district.save
    return district
  end

  def is_admin_user_central
    if !admin_user_signed_in? || current_admin_user.user_role != 'central_admin'
      reset_session
      return redirect_to '/admin_users/sign_in'
    end
  end

  def is_admin_user_central?
    return admin_user_signed_in? && current_admin_user.user_role == 'central_admin'
  end

  def is_admin_user_district
    if !admin_user_signed_in? || current_admin_user.user_role != 'district_admin'
      reset_session
      return redirect_to '/admin_users/sign_in'
    end
  end

  def is_admin_user_district?
    return admin_user_signed_in? && current_admin_user.user_role == 'district_admin'
  end

  def param_does_not_exist(model_const, field_const)
    return !params || !params[model_const] || !params[model_const][field_const] || params[model_const][field_const] == ''
  end

  # TODO this method might replace `param_does_not_exist`
  def missing_param(model_const, field_const, model_obj, error_msg)
    if !params || !params[model_const] || !params[model_const][field_const] || params[model_const][field_const] == ''
      model_obj.errors.add(field_const, error_msg)
    end
  end

  def retain_values_and_errors(obj, param_updater)
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

  def edit_supplemental_material(id)
    @admin = current_admin_user

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
    retain_values_and_errors(@supplemental_material, supplemental_material_params)
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
    if are_central_admins?
      return redirect_to action: :login
    end

    @body_class = "admin-setup admin-setup-1"
    return render 'central_setup_welcome', layout: 'admin_setup'
  end

  def central_setup_info_get
    if are_central_admins?
      return redirect_to action: :login
    end

    @admin = AdminUser.new
    @body_class = "admin-setup admin-setup-2"
    return render 'central_setup_info', layout: 'admin_setup'
  end

  def central_setup_info_post
    if are_central_admins?
      return redirect_to action: :login
    end

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

    if param_does_not_exist(:admin_user, :password_confirmation)
      @admin.errors.add(:password_confirmation, 'The password confirmation was not entered')
    end

    if params[:admin_user][:password] != params[:admin_user][:password_confirmation]
      @admin.errors.add(:password, 'The passwords do not match')
      return render 'central_setup_info', layout: 'admin_setup'
    end


    # If there were any errors, send back the same page with error messages
    @admin.password = params[:admin_user][:password]
    @admin.password_confirmation = params[:admin_user][:password_confirmation]
    retain_values_and_errors(@admin, admin_user_params)

    if @admin.errors.any?
      return render 'central_setup_info', layout: 'admin_setup'
    end

    # TODO Is there a better way to do this check using the model layer?
    if AdminUser.where(email: @admin.email).any?
      @admin.errors.add(:base, 'A user with this e-mail address already exists')
      return render action: 'central_setup_info', layout: 'admin_setup'
    end

    # Save the central admin
    begin
      @admin.save
    rescue
      @admin.errors.add(:base, 'There was an error and the user could not be registered. Talk to an admin.')
      return render 'central_setup_info', layout: 'admin_setup'
    end

    return redirect_to action: :central_setup_confirm
  end

  def central_setup_confirm
    if are_central_admins?
      return redirect_to action: :login
    end

    @body_class = "admin-setup admin-setup-3"
    render 'central_setup_confirm', layout: 'admin_setup'
  end

  # -----------
  # Central Admin Supplemental Materials
  # -----------

  def central_supplemental_materials
    @admin = current_admin_user

    @supplemental_materials = SupplementalMaterial.where(authority_level: SupplementalMaterial.authority_levels[:central])
    @supplemental_materials_required = @supplemental_materials.where(is_required: true)
    @supplemental_materials_optional = @supplemental_materials.where(is_required: false)

    return render 'central_supplemental_materials'
  end

  def central_supplemental_materials_add_get
    @admin = current_admin_user
    @title                 = 'Add a supplemental material'
    @button_title          = 'Add'

    @supplemental_material = SupplementalMaterial.new

    return render 'supplemental_materials_edit'
  end

  def central_supplemental_materials_add_post
    @admin = current_admin_user
    @title                 = 'Add a supplemental material'
    @button_title          = 'Add'
    return edit_supplemental_material(nil)
  end

  def central_supplemental_materials_edit_get
    @admin = current_admin_user
    @title                 = 'Edit supplemental material'
    @button_title          = 'Edit'
    @supplemental_material = SupplementalMaterial.find(params[:id])
    return render 'supplemental_materials_edit'
  end

  def central_supplemental_materials_edit_post
    @admin = current_admin_user
    @title                 = 'Edit supplemental material'
    @button_title          = 'Edit'
    return edit_supplemental_material(params[:id])
  end

  def central_supplemental_materials_delete_get
    @admin = current_admin_user
    @body_class = "supplemental-materials-delete"
    @supplemental_material = SupplementalMaterial.find(params[:id]) # TODO Better error checking
    return render 'supplemental_materials_delete'
  end

  def central_supplemental_materials_delete_post
    @admin = current_admin_user
    @body_class = "supplemental-materials-delete"
    @supplemental_material = SupplementalMaterial.find(params[:id]) # TODO Better error checking
    @supplemental_material.delete # TODO more error checking
    return redirect_to action: 'central_supplemental_materials'
  end

  # -----------
  # Central Admin People
  # -----------

  def edit_a_person_as_central(id)
    @admin = current_admin_user

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
      if (!params || !params[:district]) && @person.district == nil
        @person.errors.add(:district, 'Please enter a district name')
      end
      @district_name = params[:district] # populate this for re-display incase there are errors
    end

    # See if there is already someone with this e-mail address
    if !id && AdminUser.find_by(email: params[:admin_user][:email]) != nil
      @person.errors.add(:email, 'There is already a user with this email address')
    end

    # Provide ability to change the password if the user is editing their own page
    if id != nil && Integer(id) == current_admin_user.id && params[:admin_user][:password] != nil && params[:admin_user][:password_confirmation] != nil
      if params[:admin_user][:password] != params[:admin_user][:password_confirmation]
        @person.errors.add(:password, 'Password and password confirmation do not match')
      else
        @person.password = params[:admin_user][:password]
        @person.password_confirmation = params[:admin_user][:password_confirmation]
      end
    end

    # Generate a temporary password if a new district admin is being created
    if id == nil
      temp_password = SecureRandom.hex
      @person.password = temp_password
      @person.password_confirmation = temp_password
    elsif current_admin_user.user_role == 'district_admin'
      @district_name = @person.district.name
    end

    # Apply the fields and do validations (and send back errors if there are any)
    retain_values_and_errors(@person, admin_user_params)
    if @person.errors.any?
      if @person.user_role == 'district_admin'
        @district_name = @person.district.name
      end
      return render 'central_people_edit'
    end

    # Create or add to a district, and assign role type
    if @person.user_role != 'central_admin'
      if @person.district == nil
        district = District.find_by(name: @district_name)
        if district == nil
          district = create_blank_district(@district_name)
        end
        @person.district = district
        @person.user_role = :district_admin
      end
    end

    if temp_password != nil
      DistrictAdminMailer.account_created(@person, temp_password).deliver
    end

    @person.save

    @people = AdminUser.all

    return redirect_to action: 'central_people'
  end

  def central_people
    @admin = current_admin_user

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

    @admin = current_admin_user
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

    @admin = current_admin_user
    @person = AdminUser.find(params[:id]) # TODO add authority check here
    if @person.user_role == 'district_admin'
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
    @admin = current_admin_user
    @body_class = "people-delete"
    @person = AdminUser.find(params[:id]) # TODO add authority check here
    return render 'central_people_delete'
  end

  def central_people_delete_post
    @admin = current_admin_user
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
      @admin.errors.add(:password, 'Please enter a password') # TODO switch to actual password field
    end
    if param_does_not_exist(:admin_user, :password_confirmation)
      @admin.errors.add(:password_confirmation, 'Please confirm the password') # TODO switch to actual password field
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
    if param_does_not_exist(:distrct, :email)
      @district.errors.add(:email, "Please enter the district's email address")
    end

    # If there were any errors, send back the same page with error messages
    retain_values_and_errors(@admin, admin_user_params)
    retain_values_and_errors(@district, district_params)
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

    return redirect_to action: :district_applications
  end

  # -----------
  # District Admin Applications
  # -----------

  def show_district_applications(is_processed)
    @admin = AdminUser.find(current_admin_user.id)
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
    @admin = AdminUser.find(current_admin_user.id)

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
    @admin = AdminUser.find(current_admin_user.id) # TODO security check
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
    retain_values_and_errors(@student, student_params)

    @student.contact_people.each_with_index do |contact_person, index|
      params[:contact_person] = params["contact_person_#{index}"] # "artificially" fill param to ease use of assign_attributes
      retain_values_and_errors(contact_person, contact_person_params)
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
    @admin = current_admin_user
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
    @admin = current_admin_user
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
    @admin = current_admin_user # TODO auth
    @district = @admin.district

    @saved = false
    return render 'district_info'
  end

  def district_info_post
    @body_class = 'district'
    @admin = current_admin_user # TODO auth
    @district = @admin.district

    missing_param(:district, :name, @district, 'Please enter a name for the district')
    missing_param(:district, :welcome_title, @district, 'Please enter a welcome subject')
    missing_param(:district, :welcome_message, @district, 'Please enter a welcome message')
    missing_param(:district, :welcomer_name, @district, 'Please enter a welcome person name')
    missing_param(:district, :welcomer_title, @district, 'Please enter a welcome person title')
    missing_param(:district, :confirmation_title, @district, 'Please enter a confirmation subject')
    missing_param(:district, :confirmation_message, @district, 'Please enter a confirmation message')
    missing_param(:district, :street_address_1, @district, 'Please enter a street address (line 1)')
    missing_param(:district, :city, @district, 'Please enter a city')
    missing_param(:district, :state, @district, 'Please enter a state')
    missing_param(:district, :zip_code, @district, 'Please enter a ZIP code')
    missing_param(:district, :phone, @district, 'Please enter a phone number')
    missing_param(:district, :email, @district, 'Please enter an email address')

    retain_values_and_errors(@district, district_params)

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
    @admin = current_admin_user
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
    @admin                 = current_admin_user
    @supplemental_material = SupplementalMaterial.new

    return render 'supplemental_materials_edit'
  end

  def district_supplemental_materials_add_post
    @admin = current_admin_user
    @title                 = 'Add a supplemental material'
    @button_title          = 'Add'
    @body_class = 'supplemental-materials'
    return edit_supplemental_material(nil)
  end

  def district_supplemental_materials_edit_get
    @admin = current_admin_user
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
    @admin = current_admin_user
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
    @admin = current_admin_user
    @body_class = 'supplemental-materials-delete'
    @supplemental_material = SupplementalMaterial.find(params[:id]) # TODO Better error checking

    if @admin.district != @supplemental_material.district
      return render 'unauthorized'
    end

    return render 'supplemental_materials_delete'
  end

  def district_supplemental_materials_delete_post
    @admin = current_admin_user
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
    @admin = current_admin_user
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
    @admin = current_admin_user
    @body_class = 'people-new'
    @title = 'Add a district administrator'
    @button_title = 'Add'

    @person = AdminUser.new

    return render 'district_people_edit'
  end

  def district_people_add_post
    @admin = current_admin_user
    @body_class = 'people-new'
    @title = 'Add a district administrator'
    @button_title = 'Add'

    return edit_a_person_as_district(nil)
  end

  def district_people_edit_get
    @admin = current_admin_user
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
    @admin = current_admin_user
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
    @admin = current_admin_user
    @body_class = 'people-delete'
    @person = AdminUser.find(params[:id])

    if @admin.district != @person.district
      return render 'unauthorized'
    end

    return render 'district_people_delete'
  end

  def district_people_delete_post
    @admin = current_admin_user
    @body_class = 'people'
    @person = AdminUser.find(params[:id])

    if @admin.district != @person.district
      return render 'unauthorized'
    end

    @person.delete # TODO error check

    return redirect_to action: 'district_people'
  end

  def edit_a_person_as_district(id)
    @admin = current_admin_user
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
    retain_values_and_errors(@person, admin_user_params)
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
    @admin = current_admin_user
    @body_class = "export"
    @district = @admin.district
    # TODO - Add authorization code here

    @export_frequency_options = [['Automatically', :export_automatically],['Twice Daily', :export_twice_daily], ['Daily', :export_daily], ['Never', :export_never]] # TODO - Move this to a common place

    return render 'district_export_settings'
  end

  def export_settings_post
    # TODO - Disable logging on password on send
    @admin = current_admin_user
    @district = @admin.district
    @export_frequency_options = [['Automatically', :export_automatically],['Twice Daily', :export_twice_daily], ['Daily', :export_daily], ['Never', :export_never]] # TODO - Move this to a common place

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
    password_confirmation = params[:district][:sftp_password_confirmation]
    if password && password_confirmation && (password != password_confirmation)
      @district.errors.add(:password, 'Password and password confirmation do not match')
    end

    retain_values_and_errors(@district, district_params)
    if @district.errors.any?
      return render 'district_export_settings'
    end

    # Save

    @notice = 'Changes saved'
    return render 'district_export_settings'
  end

  def export_processed_now
    @admin = current_admin_user
    @district = @admin.district
    @export_frequency_options = [['Automatically', :export_automatically],['Twice Daily', :export_twice_daily], ['Daily', :export_daily], ['Never', :export_never]] # TODO - Move this to a common place
    @notice = 'Processed applications have been exported'


    return render 'district_export_settings'
  end

  # -----------
  # Authentication/Authorization
  # -----------

end
