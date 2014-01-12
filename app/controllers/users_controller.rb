class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :set_user, only: [:edit, :show, :certifications]

  def index
    @users = User.joins(:account).where(account_id: current_user.account_id)
    .active
    .includes(:location, :position).search(params[:search])
    .order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users}
      format.csv { render csv: @users, filename: 'active_users'}
    end
  end

  def all_users
    @all_users = User.joins(:account).where(account_id: current_user.account_id)
    .includes(:location, :position).search(params[:search])
    .order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @all_users}
      format.csv { render csv: @all_users, filename: 'all_users'}
    end
  end

  def inactive_index
    @inactive_users = User.joins(:account)
    .where(account_id: current_user.account_id)
    .inactive
    .includes(:location, :position).search(params[:search])
    .order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @inactive_users}
      format.csv { render csv: @inactive_users, filename: 'inactive_users'}
    end
  end

	def show
	end

  def new
  	@user = User.new
    @locations = Location.all
    @positions = Position.all
  end

  def edit
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
    @user.account_id = current_user.account_id

    if @user.save
    	flash[:success] = 'This account has been successfully created!'
    	redirect_to users_path
    else
      render 'new'
    end
  end

  def certifications
    @certifications = @user.certifications
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user)
    .permit(:admin, :active, :first_name, :last_name, :email, :password,
            :password_confirmation, :date_of_birth, :date_of_hire, :sex,
            :phone_number, :shirt_size, :suit_size, :location_id, :position_id,
            :femalesuit, :notes, :avatar, :employee_id,
            certifications_attributes: [:id, :certification_name_id,
            :user_id, :issue_date, :expiration_date, :attachment])
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
