class AdminController < ApplicationController

  def index
    @admins = AdminUser.all

    # If there are no admins created, the app was just installed -- setup a central admin
    if @admins.none?
      return central_start
    end

    return login
  end

  def central_start
    return 'central_start'
  end

  def login
    return 'login'
  end

end
