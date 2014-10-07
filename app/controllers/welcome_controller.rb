class WelcomeController < ApplicationController

	def index
    reset_session

    if !are_central_admins?
      return redirect_to '/admin/central/setup'
    end

    if !are_district_admins?
      return render 'no_districts'
    end

    return 'index'
	end
end