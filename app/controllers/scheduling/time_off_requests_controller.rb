class TimeOffRequestsController < ApplicationController
  before_action :set_time_off_request, only: [:show, :edit, :update, :destroy]

  include ApplicationHelper

  def index
    Tracker.track(current_user.id, 'Time Off Requests Index')
    @time_off_requests = TimeOffRequest.joins(:user)
    .where(users: { account_id: current_user.account_id }).joins(:location)
  end

  def show
  end

  def new
    @time_off_request = TimeOffRequest.new
  end

  def edit
  end

  def create
    Tracker.track(current_user.id, 'Create Time Off Request')
    @time_off_request = TimeOffRequest.new(time_off_request_params)

    if @time_off_request.save
      render json: @time_off_request.as_json(include: {
        user: { only: [:first_name, :last_name] },
        location: { only: :name }
      })
    else
      render json: @time_off_request.errors, status: :unprocessable_entity
    end
  end

  def update
    Tracker.track(current_user.id, 'Update Time Off Request')

    if @time_off_request.update(time_off_request_params)
      render json: @time_off_request.as_json
    else
      render json: @time_off_request.errors, status: :unprocessable_entity
    end
  end

  def archived_time_off_requests
    Tracker.track(current_user.id, 'Archived Time Off Requests')
  end

  def my_time_off_requests
    Tracker.track(current_user.id, 'My Time Off Requests')
  end

  def destroy
    Tracker.track(current_user.id, 'Delete Time Off Request')
    @time_off_request.destroy
    render json: @time_off_request
  end

  private

  def set_time_off_request
    @time_off_request = TimeOffRequest.find(params[:id])
  end

  def time_off_request_params
    params.require(:time_off_request)
    .permit(:user_id, :starts_at, :ends_at, :all_day, :reason, :approved,
            :approved_by_user_id, :approved_at, :active, :location_id,
            :processed_by_last_name, :processed_by_first_name)
  end
end
