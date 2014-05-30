module GuardianParams
  def guardian_params
    params.require(:guardian).permit(
        :first_name,
        :last_name
    )
  end
end