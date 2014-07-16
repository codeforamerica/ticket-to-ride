module StudentRaceParams
  def student_race_params
    params.require(:student_race).permit(
        :race,
        :student
    )
  end
end