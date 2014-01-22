class ShiftReportsController < ApplicationController
  before_action :set_shift_report, only: [:show, :edit, :update, :destroy]

  # GET /shift_reports
  # GET /shift_reports.json
  def index
    @shift_reports = ShiftReport.all

  end

  # GET /shift_reports/1
  # GET /shift_reports/1.json
  def show
  end

  # GET /shift_reports/new
  def new
    @shift_report = ShiftReport.new

  end


  # GET /shift_reports/1/edit
  def edit
  end

  # POST /shift_reports
  # POST /shift_reports.json
  def create
    @shift_report = ShiftReport.new(shift_report_params)
    @shift_report.user_id = current_user.id
    @shift_report.location_id = current_user.location_id

    respond_to do |format|
      if @shift_report.save
        format.html { redirect_to @shift_report, notice: 'Shift report was successfully created.' }
        format.json { render action: 'show', status: :created, location: @shift_report }
      else
        format.html { render action: 'new' }
        format.json { render json: @shift_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shift_reports/1
  # PATCH/PUT /shift_reports/1.json
  def update
    respond_to do |format|
      if @shift_report.update(shift_report_params)
        format.html { redirect_to @shift_report, notice: 'Shift report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @shift_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shift_reports/1
  # DELETE /shift_reports/1.json
  def destroy
    @shift_report.destroy
    respond_to do |format|
      format.html { redirect_to shift_reports_url }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_shift_report
      @shift_report = ShiftReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shift_report_params
      params.require(:shift_report)
        .permit(:post_title, :post_content, :date_stamp, :time_stamp, :user_id,
                :location_id, users_attributes: [:id, :first_name, :last_name])
    end

end
