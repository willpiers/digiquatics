class UsersController < ApplicationController
  include ApplicationHelper
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :set_user, only: [:edit, :show, :certifications]
  before_action :admin_user, only: [:index]

  def index
    @users = User.joins(:account).same_account_as(current_user).active

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

    if signed_in?
      @user.account_id = current_user.account_id
      if @user.save
        flash[:success] = 'This user has been successfully created!'
        redirect_to @user
      end
    else
      if @user.save
        flash[:success] = 'This user has been successfully created!'
        if @user.account.users.count == 1
          @user.update_attribute(:admin, true)
          sign_in_and_redirect @user
        else
          sign_in_and_redirect @user
        end
      else
        render 'new'
      end
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
              :emergency_phone,
              :notes,
              :payrate,
              :grouping,
              :address1,
              :address2,
              :city,
              :state,
              :zipcode,
              certifications_attributes: [:_destroy,
                                          :id,
                                          :certification_name_id,
                                          :user_id,
                                          :issue_date,
                                          :expiration_date,
                                          :attachment])
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
end
