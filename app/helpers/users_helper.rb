module UsersHelper
  USER_PARAMS = [
    :first_name, :nickname, :last_name, :account_id, :admin, :email, :password,
    :password_confirmation, :date_of_birth, :date_of_hire, :sex, :phone_number,
    :shirt_size, :suit_size, :location_id, :position_id, :femalesuit, :avatar,
    :employee_id, :emergency_first, :emergency_last, :emergency_phone, :notes,
    :payrate, :grouping, :address1, :address2, :city, :state, :zipcode,
    :active,
    certifications_attributes: [
      :_destroy, :id, :certification_name_id, :user_id, :issue_date,
      :expiration_date, :attachment
    ]
  ]

  def user_params
    params.require(:user).permit(USER_PARAMS)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to new_user_session_path, notice: 'Please sign in.'
    end
  end

  def correct_user
    @user = User.find(params[:id])

    unless current_user?(@user) || current_user.admin?
      redirect_to(new_user_session_path)
    end
  end

  def age(dob)
    return '?' unless dob

    now = Time.now.utc.to_date

    extra_year = now.month > dob.month ||
      (now.month == dob.month && now.day >= dob.day)

    now.year - dob.year - (extra_year ? 0 : 1)
  end
end
