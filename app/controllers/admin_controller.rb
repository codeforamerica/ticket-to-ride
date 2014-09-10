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
    messages = obj.errors.messages.clone()
    obj.assign_attributes(param_updater)
    messages.each do |k,v|
      v.each do |field, message|
        obj.errors.add(field, message)
        puts "Message: #{message}"
      end
    end
  end

  def get_logged_in_admin
    # TODO error handling
    admin_id = session[:admin_user_id]
    admin_user = AdminUser.find(admin_id)
    return admin_user
  end

  def edit_a_central_supplemental_material(id)
    @admin = get_logged_in_admin

    if id
      @supplemental_material = SupplementalMaterial.find(id) # TODO Better error checking
    else
      @supplemental_material = SupplementalMaterial.new
    end

    # Check fields to see if they were filled in
    if param_does_not_exist(:supplemental_material, :name)
      @supplemental_material.errors.add(:name, 'Please enter a <em>Name</em>')
    end

    if param_does_not_exist(:supplemental_material, :description)
      @supplemental_material.errors.add(:description, 'Please enter a <em>Description</em>')
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

    # No type indicated
    if num_types == 0
      @supplemental_material.errors.add(:base, 'Please enter a type')
    # Multiple types indicated
    elsif num_types > 1
      @supplemental_material.errors.add(:base, 'Multiple types were entered. Can only be one of file, link, or brought document')
    end


    if param_does_not_exist(:supplemental_material, :is_required)
      @supplemental_material.errors.add(:is_required, 'Please indicate if the supplemental material is required or not.')
    end

    # Check for errors
    retainValuesAndErrors(@supplemental_material, supplemental_material_params)
    if @supplemental_material.errors.any?
      return render 'central_supplemental_materials_edit'
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

    @supplemental_material.authority_level = :central
    @supplemental_material.save # TODO more error checking on the save

    return redirect_to action: 'central_supplemental_materials'
  end

  def param_exists(model_const, field_const)
    return !param_does_not_exist(model_const, field_const)
  end

  # -----------
  # Central Admin Setup
  # -----------

  def central_setup_welcome
    return render 'central_setup_welcome', layout: 'admin_setup'
  end

  def central_setup_info_get
    @admin = AdminUser.new
    return render 'central_setup_info', layout: 'admin_setup'
  end

  def central_setup_info_post

    @admin = AdminUser.new(user_role: :central_admin)

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
    render 'central_setup_confirm', layout: 'admin_setup'
  end

  # -----------
  # Central Admin Supplemental Materials
  # -----------

  def central_supplemental_materials
    @admin = get_logged_in_admin
    @supplemental_materials = SupplementalMaterial.where(authority_level: SupplementalMaterial.authority_levels[:central])

    unless @supplemental_materials.any?
      return render 'central_supplemental_materials_none'
    end

    # Sort by required and optional
    @supplemental_materials_required = []
    @supplemental_materials_optional = []

    @supplemental_materials.each do |sm|
      if sm.is_required
        @supplemental_materials_required << sm
      else
        @supplemental_materials_optional << sm
      end
    end

    return render 'central_supplemental_materials'
  end

  def central_supplemental_materials_add_get
    @admin = get_logged_in_admin

    @supplemental_material = SupplementalMaterial.new

    return render 'central_supplemental_materials_edit'
  end

  def central_supplemental_materials_add_post
    return edit_a_central_supplemental_material(nil)
  end

  def central_supplemental_materials_edit_get
    @admin = get_logged_in_admin

    @supplemental_material = SupplementalMaterial.find(params[:id])

    return render 'central_supplemental_materials_edit'
  end

  def central_supplemental_materials_edit_post
    return edit_a_central_supplemental_material(params[:id])
  end

  def central_supplemental_materials_delete_get
    @admin = get_logged_in_admin
    @supplemental_material = SupplementalMaterial.find(params[:id]) # TODO Better error checking
    return render 'central_supplemental_materials_delete'
  end

  def central_supplemental_materials_delete_post
    @admin = get_logged_in_admin
    @supplemental_material = SupplementalMaterial.find(params[:id]) # TODO Better error checking
    @supplemental_material.delete # TODO more error checking
    return redirect_to action: 'central_supplemental_materials'
  end

  # -----------
  # Central Admin People
  # -----------

  def edit_a_person(id)
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

    if !params || !params[:district]
      @person.errors.add(:base, 'Please enter a district name')
    end
    @district_name = params[:district] # populate this for re-display incase there are errors

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
    district = District.find_by(name: @district_name.downcase)
    if district == nil
      district = District.create(name: @district_name.downcase)
    end

    @person.district = district
    @person.user_role = :district_admin
    @person.save

    @people = AdminUser.all

    return redirect_to action: 'central_people'
  end

  def central_people
    @admin = get_logged_in_admin

    @people = AdminUser.where.not(district_id: nil).joins(:district).order('districts.name')
    unless @people.any?
      return render 'central_people_none'
    end

    return render 'central_people'
  end

  def central_people_add_get
    @admin = get_logged_in_admin
    @person = AdminUser.new
    @district_name = nil

    return render 'central_people_edit'
  end

  def central_people_add_post
    return edit_a_person(nil)
  end

  def central_people_edit_get
    @admin = get_logged_in_admin
    @person = AdminUser.find(params[:id]) # TODO add authority check here
    @district_name = @person.district.name

    return render 'central_people_edit'
  end

  def central_people_edit_post
    id = params[:id] # TODO add authority check here
    return edit_a_person(id)
  end

  def central_people_delete_get
    @admin = get_logged_in_admin
    @person = AdminUser.find(params[:id]) # TODO add authority check here
    return render 'central_people_delete'
  end

  def central_people_delete_post
    @admin = get_logged_in_admin
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
    if param_does_not_exist(:district, :mailing_street_address_1)
      @district.errors.add(:mailing_street_address_1, "Please enter the first line of the district's mailing address")
    end
    if param_does_not_exist(:district, :mailing_city)
      @district.errors.add(:mailing_city, "Please enter the district's mailing city")
    end
    if param_does_not_exist(:district, :mailing_state)
      @district.errors.add(:mailing_state, "Please enter the district's mailing state")
    end
    if param_does_not_exist(:district, :mailing_zip_code)
      @district.errors.add(:mailing_zip_code, "Please enter the district's mailing ZIP code")
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

  def show_district_applications(title, is_processed)
    @admin = AdminUser.find(session[:admin_user_id])
    @district = @admin.district
    @title = title

    # Get students for the admin's district that have completed registration, but not been processed
    @students = Student.where(district: @district).order(:guardian_complete_time)
    if is_processed
      @students = @students.where.not(export_time: nil)
    else
      @students = @students.where(export_time: nil)
    end
    @students = @students.where.not(confirmation_code: nil)

    # If no student applications completed, render holding page
    unless @students.any?
      return render 'district_applications_none'
    end

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
    return show_district_applications('Applications For Review', false)
  end

  def district_applications_processed
    return show_district_applications('Processed Applications', true)
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

  def district_application_detail_get
    @admin = AdminUser.find(session[:admin_user_id])

    @student = Student.find(params[:student_id]) # TODO Better error checking
    if @student.district != @admin.district # TODO Better authorization checking
      return render 'unauthorized'
    end

    generate_application_detail_select_options

    return render 'district_application_detail'
  end

  def are_errors(model_list)
    model_list.each do |m|
      if m.errors.any?
        return true
      end
    end

    return false
  end



  def district_application_detail_post
    @admin = AdminUser.find(session[:admin_user_id]) # TODO security check
    @student = Student.find(params[:student_id]) # TODO error checking

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
    unless @student.errors.any? || are_errors(@student.contact_people) || are_errors(@student.student_races)
      # Add all races to student, but remove the existing ones first
      @student.student_races.each {|r| r.delete}

      params['races'].each do |race|
        begin
          StudentRace.create(race: race, student: @student )
        rescue
          @student.errors.add(:race, 'Could not assign race')
          return render 'district_application_detail'
        end
      end

      # Save contact people
      @student.contact_people.each {|contact_person| contact_person.save}

      # Save student
      @student.save # TODO error check here
      @student.reload # refreshes transitive values, like race and contact people
    end

    # Prep anything for rendering a page
    generate_application_detail_select_options

    return render 'district_application_detail'
  end

  def missing_contact_person_params(contact_person, contact_person_number, contact_person_title)
    missing_param("contact_person_#{contact_person_number}", :first_name, contact_person, "#{contact_person_title}'s first name is required")
    missing_param("contact_person_#{contact_person_number}", :last_name, contact_person, "#{contact_person_title}'s last name is required")
    missing_param("contact_person_#{contact_person_number}", :relationship, contact_person, "#{contact_person_title}'s relationship to student is required")
    missing_param("contact_person_#{contact_person_number}", :mailing_street_address_1, contact_person, "#{contact_person_title}'s mailing street address line 1 is required")
    missing_param("contact_person_#{contact_person_number}", :mailing_city, contact_person, "#{contact_person_title}'s mailing city is required")
    missing_param("contact_person_#{contact_person_number}", :mailing_state, contact_person, "#{contact_person_title}'s state is required")
    missing_param("contact_person_#{contact_person_number}", :mailing_zip_code, contact_person, "#{contact_person_title}'s ZIP code is required")
    missing_param("contact_person_#{contact_person_number}", :main_phone, contact_person, "#{contact_person_title}'s phone number is required")
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
