module AccountsHelper
  ACCOUNT_PARAMS = [:name, :time_zone, :logo,
                    :slides_admin_email, :slides_location_email,
                    :slides_group_email, :maintenance_admin_email,
                    :maintenance_location_email, :maintenance_group_email,
                    :chemical_records_admin_email,
                    :chemical_records_location_email,
                    :chemical_records_group_email,
                    private_lessons_attributes: [:id],
                    users_attributes: [
                      :first_name, :nickname, :last_name, :email, :account_id,
                      :password, :password_confirmation, :phone_number]
                   ]

  def account_params
    params.require(:account).permit(ACCOUNT_PARAMS)
  end
end
