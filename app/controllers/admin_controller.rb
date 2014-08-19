class AdminController < ApplicationController
  layout 'admin'

  def index
    @admins = AdminUser.all

    # If there are no admins created, the app was just installed -- setup a central admin
    if @admins.none?
      return central_start
    end

    return admin_login
  end

  # -----------
  # Central Admin Setup
  # -----------

  def central_setup_welcome
    render 'central_setup_welcome'
  end

  def central_setup_info

    @errors = {}

    # GET
    if request.method_symbol == :get
      render 'central_setup_info'
    end

    # POST

    # Empty checks
    name = request.POST['name']
    if name == nil
      @errors[:name] = 'No name was entered'
    end

    email = request.POST['email']
    if email == nil
      @errors[:email] = 'E-mail address was not entered'
    end

    password = request.POST['password']
    if password == nil
      @errors[:password] = 'Password was not entered'
    end

    confirm_password = request.POST['confirm_password']
    if confirm_password == nil
      @errors[:confirm_password] = 'The password confirmation was not entered'
    end

    if @errors.any?
      render 'central_setup_info'
    end

    # Create the object and check validations
    central_admin = AdminUser.create(name: name, email: email, user_role: :central_admin)

    if !central_admin.valid?
      @errors = central_admin.errors
      render 'central_setup_info'
    end

    central_admin.active = true
    central_admin.save

    render action: 'central_setup_confirm'
  end

  def central_setup_confirm
    render 'central_setup_confirm'
  end

  # -----------
  # Authentication/Authorization
  # -----------
  def admin_login
    render 'admin_login'
  end

  def show
    page_id = request.filtered_parameters['id']
    render page_id
  end

end
