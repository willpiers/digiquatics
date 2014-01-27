class AttendanceRecordsController < ApplicationController
  before_action :set_attendance_record, only: [:show, :edit, :update, :destroy]

  # GET /attendance_records
  # GET /attendance_records.json
  def index
    @attendance_records = AttendanceRecord.all
  end

  # GET /attendance_records/1
  # GET /attendance_records/1.json
  def show
  end

  # GET /attendance_records/new
  def new
    @attendance_record = AttendanceRecord.new
  end

  # GET /attendance_records/1/edit
  def edit
  end

  # POST /attendance_records
  # POST /attendance_records.json
  def create
    @attendance_record = AttendanceRecord.new(attendance_record_params)

    if @attendance_record.save
      flash[:success] = 'Attendance record was successfully created.'
      redirect_to @attendance_record
    else
      render 'new'
    end
  end

  # PATCH/PUT /attendance_records/1
  # PATCH/PUT /attendance_records/1.json
  def update
    if @attendance_record.update(attendance_record_params)
      flash[:success] = 'Attendance record was successfully updated.'
      redirect_to @attendance_record
    else
      render 'edit'
    end
  end

  # DELETE /attendance_records/1
  # DELETE /attendance_records/1.json
  def destroy
    @attendance_record.destroy
    redirect_to attendance_records_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance_record
      @attendance_record = AttendanceRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_record_params
      params.require(:attendance_record).permit(:name)
    end
end
