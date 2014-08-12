class ShiftReportsController < ApplicationController
  before_action :set_shift_report, only: [:show, :edit, :update, :destroy]

  def index
    Tracker.track(current_user.id, 'Shift Reports Index') unless Rails.env.test?
    @shift_reports = ShiftReport.joins(:location)
                     .where(locations: { account_id: current_user.account_id })

    respond_to do |format|
      format.html
      format.json
      format.csv do
        render csv: @shift_reports, filename: 'shift_reports'
      end
    end
  end

  def show
    Tracker.track(current_user.id, 'Show Shift Report') unless Rails.env.test?
  end

  def new
    @shift_report = ShiftReport.new
  end

  def edit
    Tracker.track(current_user.id, 'Edit Shift Report') unless Rails.env.test?
  end

  def create
    Tracker.track(current_user.id, 'Create Shift Report') unless Rails.env.test?
    @shift_report = ShiftReport.new(shift_report_params)
    @shift_report.user_id = current_user.id

    message = 'Shift Report was successfully created.'

    handle_action(@shift_report, message, :new, &:save)
  end

  def update
    Tracker.track(current_user.id, 'Update Shift Report') unless Rails.env.test?
    message = 'Shift Report was successfully updated.'

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
