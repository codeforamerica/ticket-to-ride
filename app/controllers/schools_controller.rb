class SchoolsController < ApplicationController

  before_filter :prepare_leas

  def index
    @schools = School.all
    @cranston_schools = School.where(lea_code:7).reorder('level')
    @newport_schools = School.where(lea_code:21).reorder('level')
    @westwarwick_schools = School.where(lea_code:38).reorder('level')
  end

  # add the @leas = Lea.All to the before action so avail for all actions

  private

  def prepare_leas
    @leas = Lea.all
  end
end

