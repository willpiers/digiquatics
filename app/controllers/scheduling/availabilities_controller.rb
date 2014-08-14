class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: [:show, :edit, :update, :destroy]

  def index
    Tracker.track(current_user.id, 'Availability Page') unless Rails.env.test?
    @availabilities = Availability.where(user_id: current_user.id)
    respond_to do |format|
      format.html
      format.json do
        render json: @availabilities.to_json
      end
    end
  end

  def show
  end

  def new
    @availability = Availability.new
  end

  def edit
  end

  def create
    @availability = Availability.new(availability_params)
    @availability.user_id = current_user.id

    message = 'Availability was successfully created.'

    handle_action(@availability, message, :new, &:save)
  end

  def update
    message = 'Availability was successfully updated.'

    handle_action(@availability, message, :edit) do |resource|
      resource.update(availability_params)
    end
  end

  def destroy
    @availability.destroy
    render :show
  end

  private

  def set_availability
    @availability = Availability.find(params[:id])
  end

  def availability_params
    params.require(:availability)
    .permit(:day, :start_time, :end_time)
  end

  def handle_action(resource, message, page)
    if yield(resource)
      render :show
    else
      render page
    end
  end
end
