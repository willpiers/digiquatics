module AccountsHelper
  ACCOUNT_PARAMS = [:name, :time_zone, :logo,
                    private_lessons_attributes: [:id],
                    users_attributes: [
                      :first_name, :nickname, :last_name, :email, :account_id,
                      :password, :password_confirmation, :phone_number]
                   ]

  def account_params
    params.require(:account).permit(ACCOUNT_PARAMS)
  end
end
