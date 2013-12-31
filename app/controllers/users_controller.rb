class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  #before_action :admin, only: [:edit, :update]

  def index
    @users = User.joins(:account).where(account_id: current_user.account_id)
    @users = User.includes(:location, :position).search(params[:search]).order(sort_column + " " + sort_direction)
  end

	def show
		@user = User.find(params[:id])
	end

  def new
  	@user = User.new
    @locations = Location.all
    @positions = Position.all
  end

  def edit
    @user = User.find(params[:id])
    @certifications = @user.certifications
    @location = @user.location
    @position = @user.position
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    @user.account_id = current_user ? current_user.account_id : 1
    if @user.save
    	sign_in @user
    	flash[:success] = 'This account has been successfully created!'
    	redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :password_confirmation, :date_of_birth, :date_of_hire, :sex, :phone_number, :shirt_size, :suit_size, :location_id, :position_id, :femalesuit)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: 'Please sign in.'
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end
  end

  def sort_column
    params[:sort] || "first_name"
  end

  def sort_direction
    params[:direction] || "asc"
  end






