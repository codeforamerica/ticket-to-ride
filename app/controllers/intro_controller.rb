class IntroController < ApplicationController

  layout "introduction"
  layout 'admin'

  def index
    reset_session
  end
end