class ShiftReportsController < ApplicationController
  before_action :set_shift_report, only: [:show, :edit, :update, :destroy]

  def index
    @shift_reports = ShiftReport.all

    respond_to do |format|
      format.html
      format.json
      format.csv do
        render csv: @shift_reports, filename: 'shift_reports'
      end
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

    message = 'Shift report was successfully created.'

    handle_action(@shift_report, message, :new, &:save)
  end

  def update
    message = 'Shift report was successfully updated.'

    handle_action(@shift_report, message, :edit) do |resource|
      resource.update(shift_report_params)
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
    .permit(:content, :user_id,
            :location_id, :report_filed, :attachment_front, :attachment_back,
            users_attributes: [:id, :first_name, :last_name])
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
