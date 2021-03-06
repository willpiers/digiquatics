class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]

  def index
    Tracker.track(current_user.id, 'Schedule Index')
    @shifts = Shift.all
    respond_to do |format|
      format.html
      format.json do
        render json: oj_dumper(@shifts)
      end
    end
  end

  def my_schedule
    Tracker.track(current_user.id, 'My Schedule')
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

  def new
    @shift = Shift.new
  end

  def create
    Tracker.track(current_user.id, 'Create Shift') unless Rails.env.test?
    @shift = Shift.new(shift_params)

    if @shift.save
      render json: @shift.to_json(include: {
        position: { only: :name },
        location: { only: :name }
      })
    else
      render json: @shift.errors, status: :unprocessable_entity
    end
  end

  def update
    Tracker.track(current_user.id, 'Update Shift') unless Rails.env.test?
    if @shift.update(shift_params)
      render json: @shift.to_json(include: {
        position: { only: :name },
        location: { only: :name }
      })
    else
      render json: @shift.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Tracker.track(current_user.id, 'Delete Shift') unless Rails.env.test?
    @shift.destroy
    head :no_content
  end

  private

  def set_shift
    @shift = Shift.find(params[:id])
  end

  def shift_params
    params.require(:shift)
    .permit(:user_id, :location_id, :position_id, :start_time, :end_time)
  end

  def oj_dumper(view)
    Oj.dump(view.select([:id, :user_id, :location_id, :position_id, :start_time,
                          :end_time]), mode: :compat)
  end

  def handle_action(resource, page)
    if yield(resource)
      render :index
    else
      render page
    end
  end
end
