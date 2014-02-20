class ShiftReportsController < ApplicationController
  before_action :set_shift_report, only: [:show, :edit, :update, :destroy]

  def index
    @shift_reports = ShiftReport.all
    respond_to do |format|
      format.html # index.html.erb
      format.csv { render csv: @shift_reports, filename: 'shift_reports' }
    end
  end

  def show
  end

  def new
    @shift_report = ShiftReport.new
  end

  def edit
  end

  def create
    @shift_report = ShiftReport.new(shift_report_params)
    @shift_report.user_id = current_user.id
    @shift_report.location_id = current_user.location_id

    if @shift_report.save
      flash[:success] = 'Shift report was successfully created.'
      redirect_to @shift_report
    else
      render 'new'
    end
  end

  def update
    if @shift_report.update(shift_report_params)
      flash[:success] = 'Shift report was successfully updated.'
      redirect_to @shift_report
    else
      render 'edit'
    end
  end

  def destroy
    @shift_report.destroy

    redirect_to shift_reports_url
  end

  private

  def set_shift_report
    @shift_report = ShiftReport.find(params[:id])
  end

  def shift_report_params
    params.require(:shift_report)
      .permit(:post_title, :post_content, :date_stamp, :time_stamp, :user_id,
              :location_id, :report_filed, :attachment_front, :attachment_back,
              users_attributes: [:id, :first_name, :last_name])
  end
end
