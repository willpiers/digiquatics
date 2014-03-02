class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]
  before_action :set_user, only: [:edit, :show, :certifications]
  before_action :admin_user, only: [:index]

  def index
    @users = User.joins(:account).same_account_as(current_user).active

    respond_to do |format|
      with_users_data(format, filename: 'active_users')
    end
  end

  def inactive_index
    @users = User.joins(:account).same_account_as(current_user).inactive

    respond_to do |format|
      with_users_data(format, filename: 'inactive_users')
    end
  end

  def show
  end

  def new
    @user      = User.new
    @locations = Location.all
    @positions = Position.all

    @user.certifications.build
  end

  def edit
    @location = @user.location
    @position = @user.position
  end

  def update
    if @user.update_attributes(user_params)
      sign_in(@user, bypass: true) if @user == current_user
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)

    @user.update_attribute(*updated_access) if should_update?
    @user.save ? redirect_to_created_user : render('new')
  end

  def certifications
    @certifications = @user.certifications
  end

  private

  include ApplicationHelper
  include UsersHelper

  def redirect_to_created_user
    flash[:success] = 'You have successfully created a user account!'

    signed_in? ? redirect_to(@user) : sign_in_and_redirect(@user)
  end

  def updated_access
    if signed_in?
      [:account_id, current_user.account_id]
    else
      [:admin, first_account_user?]
    end
  end

  def should_update?
    @user.valid? || @user.account_id.nil?
  end

  def with_users_data(format, filename: 'users')
    format.html
    format.csv { render csv: @users, filename: filename }

    format.json do
      render json: @users.to_json(include: [:location, :position])
    end
  end

  def first_account_user?
    @user.account.users.empty?
  end

  def set_user
    @user = User.find(params[:id])
  end
end
