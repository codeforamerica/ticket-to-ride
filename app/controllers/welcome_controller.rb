class WelcomeController < ApplicationController

	def choose_district
    reset_session

    if !are_central_admins?
      return redirect_to '/admin/central/setup'
    end

    if !are_district_admins?
      return render 'no_districts'
    end

    @district_names = []
    District.all.each do |district|
      @district_names << district.name.capitalize
    end

    return render 'index'
  end

  def welcome
    @district = District.where( url: params['district_url']).first

    if @district == nil
      return redirect_to action: :choose_district
    end

    if @district.welcome_title == nil # TODO Make this check more exhaustive
      return render 'welcome_config'
    end

    session[:district_id] = @district.id
    return render 'welcome'
  end
end