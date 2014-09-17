class AttendanceRecordsController < ApplicationController
  before_action :set_attendance_record, only: [:show, :edit, :update, :destroy]

  def index
    Tracker.track(current_user.id, 'Attendance Record Index')
    @attendance_records = AttendanceRecord.all
  end

  def show
  end

  def new
    @attendance_record = AttendanceRecord.new
  end

  def edit
  end

  def create
    @attendance_record = AttendanceRecord.new(attendance_record_params)

    if @attendance_record.save
      flash[:success] = 'Attendance record was successfully created.'
      redirect_to @attendance_record
    else
      render 'new'
    end
  end

  def update
    if @attendance_record.update(attendance_record_params)
      flash[:success] = 'Attendance record was successfully updated.'
      redirect_to @attendance_record
    else
      render 'edit'
    end
  end

  def destroy
    @attendance_record.destroy
    redirect_to attendance_records_url
  end

  private

  def set_attendance_record
    @attendance_record = AttendanceRecord.find(params[:id])
  end

  def attendance_record_params
    params.require(:attendance_record).permit(:name)
  end
end
