module StudentParams
  def student_params
    params.require(:student).permit(
        :first_name,
        :last_name,
        :home_city
    )
  end
end