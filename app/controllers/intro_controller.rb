class IntroController < ApplicationController

  layout "introduction"

  def index
    reset_session
  end
end