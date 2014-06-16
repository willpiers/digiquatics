class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: [:show, :edit, :update, :destroy]

  def index
    @availabilities = Availability.all

    # respond_to do |format|
    #   format.html
    #   format.json
    #   format.csv do
    #     render csv: @availabilities, filename: 'Availabilitys'
    #   end
    # end
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
    .permit(:user_id)
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
