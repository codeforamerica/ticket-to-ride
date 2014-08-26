require 'admin_user_params'

class AdminController < ApplicationController
  include AdminUserParams

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

    return redirect_to action: :central_setup_confirm
  end

  def central_setup_confirm
    render 'central_setup_confirm', layout: 'admin_setup'
  end

  # -----------
  # Central Admin Supplemental Materials
  # -----------

  def central_supplmental_materials
    @admin_user = get_logged_in_admin




    return render 'central_supplemental_materials', layout: 'admin'
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
    return render action: 'central_supplemental_materials', layout: 'admin'
    # end
  end

  def show
    page_id = request.filtered_parameters['id']
    return render page_id
  end

end
