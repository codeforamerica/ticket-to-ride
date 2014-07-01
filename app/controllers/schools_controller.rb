class SchoolsController < ApplicationController
  def index
    @schools = School.all
    @leas = Lea.all
    @cranston_schools = School.where(lea_code:7).reorder('level')
    @newport_schools = School.where(lea_code:21).reorder('level')
    @westwarwick_schools = School.where(lea_code:38).reorder('level')
  end
end