class WelcomeController < ApplicationController

	def index
    reset_session

    if !are_admins?
      redirect_to '/admin/central/setup'
    end
	end
end