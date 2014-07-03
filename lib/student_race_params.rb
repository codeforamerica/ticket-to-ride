module StudentRaceParams
  def student_race_params
    params.require(:student_race).permit(
        :primary_race
        :additional_races
    )
  end
end