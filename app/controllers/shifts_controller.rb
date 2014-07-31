class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]

  def index
    @shifts = Shift.all

    respond_to do |format|
      format.html
      format.json
      format.csv do
        render csv: @shifts, filename: 'shifts'
      end
    end
  end

  def my_schedule
    @my_schedule = Shift.all

    respond_to do |format|
      format.html
      format.json do
        my_schedule = User.where(id: current_user.id).select("id, first_name, last_name")

        render json: my_schedule.to_json(include: [
              {shifts: { include: {position: {only: :name}, location: {only: :name} } }},
              :time_off_requests,
              :availabilities])
      end
    end
  end

  def show

  end

  def new
    @shift = Shift.new
  end

  def edit
  end

  def create
    @shift = Shift.new(shift_params)
    handle_action(@shift, :new, &:save)
  end

  def update
    handle_action(@shift, :edit) do |resource|
      resource.update(shift_params)
    end
  end

  def destroy
    @shift.destroy

    redirect_to shifts_url
  end

  private

  def set_shift
    @shift = Shift.find(params[:id])
  end

  def shift_params
    params.require(:shift)
    .permit(:user_id, :location_id, :position_id, :start_time, :end_time)
  end

  def handle_action(resource, page)
    if yield(resource)
      render :show
    else
      render page
    end
  end
end
