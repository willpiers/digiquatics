class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: [:show, :edit, :update, :destroy]

  def index
    @availabilities = Availability.all
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

    redirect_to availabilities_url
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
      flash[:success] = message
      redirect_to resource
    else
      render page
    end
  end
end
