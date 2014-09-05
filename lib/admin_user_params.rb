module AdminUserParams
  def admin_user_params
    params.require(:admin_user).permit(
      :name,
      :email,
      :active
    )
  end
end