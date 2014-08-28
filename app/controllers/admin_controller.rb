require 'admin_user_params'
require 'supplemental_materials_param'

class AdminController < ApplicationController
  include AdminUserParams
  include SupplementalMaterialParams

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

  def retainValuesAndErrors(obj, param_updater)
    messages = obj.errors.messages.clone()
    obj.assign_attributes(param_updater) # Note - this actually saves something to the DB
    messages.each do |k,v|
      v.each {|e| obj.errors.add(k,e)}
    end
  end

  def get_logged_in_admin
    # TODO error handling
    admin_id = session[:admin_id]
    admin_user = AdminUser.find(admin_id)
    return admin_user
  end

  def edit_a_central_supplemental_material(id)
    @admin_user = get_logged_in_admin

    if id
      @supplemental_material = SupplementalMaterial.find(id) # TODO plusjeff: Better error checking
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

    if !params[:file_upload]
      if !params[:link_url]
        @supplemental_material.errors.add(:base, 'Either a <em>File upload</em> or <em>Link URL</em> must be entered')
      end
    else params[:file_upload] && params[:link_url] && params[:link_url] != ''
    @supplemental_material.errors.add(:base, 'Only one of file upload or link URL can be entered, but not both')
    end

    if param_does_not_exist(:supplemental_material, :is_required)
      @supplemental_material.errors.add(:is_required, 'Please indicate if the supplemental material is required or not.')
    end

    # TODO Use Paperclip gem in the future -- comment out for now
    # path = File.join('public', 'files', 'supplemental_materials', params[:file_upload].to_s)
    # File.open(path, 'wb') {|f| f.write(params[:file_upload].read)}

    # Check for errors
    retainValuesAndErrors(@supplemental_material, supplemental_material_params)
    if @supplemental_material.errors.any?
      return render 'central_supplemental_materials_edit'
    end

    # Populate any other fields and save
    if params[:file_upload]
      @supplemental_material.req_type = :file
      @supplemental_material.uri = params[:file_upload].to_s # TODO fix this for file uploads
    else
      @supplemental_material.req_type = :url
      @supplemental_material.uri = params[:link_url]
    end
    @supplemental_material.authority_level = :central
    @supplemental_material.save # TODO more error checking on the save

    return redirect_to action: 'central_supplemental_materials'
  end

  # -----------
  # Central Admin Setup
  # -----------

  def central_setup_welcome
    return render 'central_setup_welcome', layout: 'admin_setup'
  end

  def central_setup_info_get
    @central_admin = AdminUser.new
    return render 'central_setup_info', layout: 'admin_setup'
  end

  def central_setup_info_post

    @central_admin = AdminUser.new(user_role: :central_admin)

    # Were the fields filled out?
    if param_does_not_exist(:admin_user, :name)
      @central_admin.errors.add(:name, 'No name was entered')
    end

    if param_does_not_exist(:admin_user, :email)
      @central_admin.errors.add(:email, 'E-mail address was not entered')
    end

    if param_does_not_exist(:admin_user, :password)
      @central_admin.errors.add(:password, 'Password was not entered')
    end

    if param_does_not_exist(:admin_user, :confirm_password)
      @central_admin.errors.add(:confirm_password, 'The password confirmation was not entered')
    end

    # If there were any errors, send back the same page with error messages
    retainValuesAndErrors(@central_admin, admin_user_params)
    if @central_admin.errors.any?
      return render 'central_setup_info', layout: 'admin_setup'
    end

    # TODO Is there a better way to do this check using the model layer?
    if AdminUser.where(email: @central_admin.email).any?
      @central_admin.errors.add(:base, 'A user with this e-mail address already exists')
      return render action: 'central_setup_info', layout: 'admin_setup'
    end

    # Save the central admin
    @central_admin.active = true
    @central_admin.save
    session[:admin_id] = @central_admin.id

    return redirect_to action: :central_setup_confirm
  end

  def central_setup_confirm
    render 'central_setup_confirm', layout: 'admin_setup'
  end

  # -----------
  # Central Admin Supplemental Materials
  # -----------

  def central_supplemental_materials
    @admin_user = get_logged_in_admin
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
    @admin_user = get_logged_in_admin

    @supplemental_material = SupplementalMaterial.new

    return render 'central_supplemental_materials_edit'
  end

  def central_supplemental_materials_add_post
    return edit_a_central_supplemental_material(nil)
  end

  def central_supplemental_materials_edit_get
    @admin_user = get_logged_in_admin

    @supplemental_material = SupplementalMaterial.find(params[:id])

    return render 'central_supplemental_materials_edit'
  end

  def central_supplemental_materials_edit_post
    return edit_a_central_supplemental_material(params[:id])
  end

  def central_supplemental_materials_delete_get
    @admin_user = get_logged_in_admin
    @supplemental_material = SupplementalMaterial.find(params[:id]) # TODO Better error checking
    return render 'central_supplemental_materials_delete'
  end

  def central_supplemental_materials_delete_post
    @admin_user = get_logged_in_admin
    @supplemental_material = SupplementalMaterial.find(params[:id]) # TODO Better error checking
    @supplemental_material.delete # TODO more error checking
    return redirect_to action: 'central_supplemental_materials'
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

    # if admin_user.password == password
    session[:admin_id] = admin_user.id
    return redirect_to action: 'central_supplemental_materials'
    # end
  end

  def show
    page_id = request.filtered_parameters['id']
    return render page_id
  end

end
