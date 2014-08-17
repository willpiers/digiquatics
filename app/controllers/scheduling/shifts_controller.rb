class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]

  def index
    Tracker.track(current_user.id, 'Schedule Index') unless Rails.env.test?
    @shifts = Shift.same_account_as(current_user)
    respond_to do |format|
      format.html
      format.json
      format.csv do
        render csv: @shifts, filename: 'shifts'
      end
    end
  end

  def my_schedule
    Tracker.track(current_user.id, 'My Schedule') unless Rails.env.test?
    @my_schedule = Shift.same_account_as(current_user)
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
    render :show
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
