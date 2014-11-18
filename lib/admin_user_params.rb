module AdminUserParams
  def admin_user_params
    params.require(:admin_user).permit(
      :name,
      :email,
      :district,
      :district_id
    )
  end
end