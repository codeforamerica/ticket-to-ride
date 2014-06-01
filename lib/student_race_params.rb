module StudentRaceParams
  def student_race_params
    params.require(:student_race).permit(
        :race
    )
  end
end