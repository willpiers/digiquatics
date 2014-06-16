class TimeOffRequestsController < ApplicationController
  before_action :set_time_off_request, only: [:show, :edit, :update, :destroy]

  def index
    @time_off_requests = TimeOffRequest.all

    # respond_to do |format|
    #   format.html
    #   format.json
    #   format.csv do
    #     render csv: @time_off_requests, filename: 'TimeOffRequests'
    #   end
    # end
  end

  def show
  end

  def new
    @time_off_request = TimeOffRequest.new
  end

  def edit
  end

  def create
    @time_off_request = TimeOffRequest.new(time_off_request_params)
    @time_off_request.user_id = current_user.id

    message = 'Time Off Request was successfully created.'

    handle_action(@time_off_request, message, :new, &:save)
  end

  def update
    message = 'Time Off Request was successfully updated.'

    handle_action(@time_off_request, message, :edit) do |resource|
      resource.update(time_off_request_params)
    end
  end

  def destroy
    @time_off_request.destroy

    redirect_to time_off_requests_url
  end

  private

  def set_time_off_request
    @time_off_request = TimeOffRequest.find(params[:id])
  end

  def time_off_request_params
    params.require(:time_off_request)
    .permit(:user_id, :starts_at, :ends_at, :reason, :approved,
            :approved_by_user_id, :approved_at)
  end

  def handle_action(resource, message, page)
    if yield(resource)
      flash[:success] = message
      redirect_to resource
    else
      render page
    end
  end
end
