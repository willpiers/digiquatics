class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]
  before_action :set_user, only: [:edit, :show, :certifications]
  before_action :admin_user, only: ['inactive_index']

  def index
    respond_to do |format|
      format.html do
        unless Rails.env.test?
          Tracker.track(current_user.id, 'View User\'s Index')
        end
      end

      format.csv do
        users = User.joins(:account).same_account_as(current_user).active

        render csv: users, filename: 'active_users'
      end

      format.json do
        users = User.same_account_as(current_user).active

        render json: users.to_json(include: [
          :location, {position: {only: :name}},
          {shifts: { include: {position: {only: :name} } }},
          :time_off_requests,
          :availabilities, :certifications])
      end
    end
  end

  def inactive_index
    respond_to do |format|
      format.html

      format.csv do
        users = User.joins(:account).same_account_as(current_user).inactive

        render csv: users, filename: 'inactive_users'
      end

      format.json do
        users = User.same_account_as(current_user).inactive

        if stale?(users)
          render json: users.to_json(include: [:location, :position])
        end
      end
    end
  end

  def show
  end

  def new
    if current_user
      @user      = User.new
      @locations = Location.all
      @positions = Position.all
      @user.certifications.build
    else
      @user = User.new
      render layout: 'devise'
    end
  end

  def edit
    @location = @user.location
    @position = @user.position
  end

  def update
    if @user.update_attributes(user_params)
      mixpanel_track_people
      sign_in(@user, bypass: true) if @user == current_user
      flash[:info] = 'Employee Profile updated'
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

  def mixpanel_track_people
    Tracker.people.set(@user.id, @user.attributes) unless Rails.env.test?
  end

  def redirect_to_created_user
    mixpanel_track_people

    flash[:success] = 'You have successfully added a new employee!'
    if signed_in?
      Tracker.track(current_user.id, 'Create New User',
                    created_user_id: @user.id) unless Rails.env.test?
      redirect_to(@user)
    else
      sign_in_and_redirect(@user)
    end
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

  def first_account_user?
    @user.account.users.empty?
  end

  def set_user
    @user = User.find(params[:id])
  end
end
