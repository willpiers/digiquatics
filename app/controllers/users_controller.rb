class UsersController < ApplicationController
  include ApplicationHelper
  helper_method :sort_column, :sort_direction
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :set_user, only: [:edit, :show, :certifications]
  before_action :admin_user, only: [:index]

  def index
    @users = User.joins(:account).same_account_as(current_user).active
      .order("#{sort_column} #{sort_direction}")

    respond_to do |format|
      format.html
      format.csv { render csv: @users, filename: 'active_users' }
      format.json do
        render json: @users.to_json(include: [:location, :position])
      end
    end
  end

  def inactive_index
    @inactive_users = User.joins(:account).same_account_as(current_user)
      .inactive

    respond_to do |format|
      format.html
      format.csv { render csv: @inactive_users, filename: 'inactive_users' }
      format.json do
        render json: @inactive_users.to_json(include: [:location, :position])
      end
    end
  end

  def show
  end

  def new
    @user = User.new
    @locations = Location.all
    @positions = Position.all
    1.times { @user.certifications.build }
  end

  def edit
    @location = @user.location
    @position = @user.position
  end

  def update
    if @user.update_attributes(user_params)
      sign_in(@user, bypass: true)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      if @user.account.users.count == 1
        @user.update_attribute(:admin, true)
        flash[:success] = 'This user has been successfully created!'
        sign_in_and_redirect @user
      else
        flash[:success] = 'This user has been successfully created!'
        sign_in_and_redirect @user
      end
    else
      render 'new'
    end
  end

  def certifications
    @certifications = @user.certifications
  end

  private

  include UsersHelper

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    if current_user && current_user.admin?
      params.require(:user).permit!
    else
      params.require(:user)
        .permit(:first_name,
                :nickname,
                :last_name,
                :account_id,
                :admin,
                :email,
                :password,
                :password_confirmation,
                :date_of_birth,
                :date_of_hire,
                :sex,
                :phone_number,
                :shirt_size,
                :suit_size,
                :location_id,
                :position_id,
                :femalesuit,
                :avatar,
                :employee_id,
                :emergency_first,
                :emergency_last,
                :emergeny_phone,
                :payrate,
                :grouping,
                :address1,
                :address2,
                :city,
                :state,
                :zipcode,
                certifications_attributes: [:id,
                                            :certification_name_id,
                                            :user_id,
                                            :issue_date,
                                            :expiration_date,
                                            :attachment])
    end
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to new_user_session_path, notice: 'Please sign in.'
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(new_user_session_path) unless current_user?(@user) || current_user.admin?
  end

  def sort_column
    params[:sort] || 'first_name'
  end

  def sort_direction
    params[:direction] || 'asc'
  end
end
