class ChemicalRecordsController < ApplicationController
  include ChemicalRecordsHelper
  before_action :set_chemical_record, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:edit]
  before_action :chemical_records_access,
                only: [:index, :show, :edit, :update, :destroy, :new]

  def index
    Tracker.track(current_user.id, 'View Chemical Records Index')
    @chemical_records = ChemicalRecord.same_account_as(current_user)

    respond_to do |format|
      format.html
      format.json
      format.csv do
        render csv: @chemical_records, filename: 'chemical_records'
      end
    end
  end

  def show
    Tracker.track(current_user.id, 'Show Chemical Record')
  end

  def new
    @chemical_record = ChemicalRecord.new
  end

  def edit
    Tracker.track(current_user.id, 'Edit Chemical Record')
  end

  def create
    Tracker.track(current_user.id, 'Create Chemical Record')
    @chemical_record = ChemicalRecord.new(chemical_record_params)
    calculations(@chemical_record)
    record_saved?(@chemical_record)
  end

  def update
    Tracker.track(current_user.id, 'Update Chemical Record')
    if @chemical_record.update(chemical_record_params)
      calculations(@chemical_record)
      @chemical_record.save!
      record_updated?(@chemical_record)
    else
      render 'edit'
    end
  end

  def destroy
    @chemical_record.destroy
    redirect_to chemical_records_url
    flash[:error] = 'Chemical Record was successfully deleted.'
  end

  private

  include ApplicationHelper

  def set_chemical_record
    @chemical_record = ChemicalRecord.find(params[:id])
  end

  def chemical_record_params
    params.require(:chemical_record)
    .permit(:free_chlorine_ppm, :total_chlorine_ppm, :chlorine_orp, :ph,
            :alkalinity, :calcium_hardness, :pool_temp, :air_temp, :si_index,
            :time_stamp, :user_id, :pool_id, :water_clarity, :location_id)
  end

  def si_index(record)
    record.si_index =
      si_index_calculator(record.ph,
                          record.pool_temp,
                          record.calcium_hardness,
                          record.alkalinity)
  end

  def chlorine_calculation(record)
    record.combined_chlorine_ppm =
      combined_calculator(record.total_chlorine_ppm,
                          record.free_chlorine_ppm)
  end

  def record_saved?(record)
    if record.save
      flash[:success] = 'Chemical record was successfully created.'
      redirect_to record
    else
      render 'new'
    end
  end

  def record_updated?(record)
    flash[:info] = 'Chemical record was successfully updated.'
    redirect_to @chemical_record
  end

  def calculations(record)
    si_index(record)
    record.si_status = si_calc(record.si_index, :status)
    record.si_recommendation = si_calc(record.si_index, :recommendation)
    record.user_id = current_user.id
    chlorine_calculation(record)
  end

  # if need_email_alert?(@chemical_record)
  #   urgent_email(@chemical_record)
  # end

  # def urgent_email(record)
  #   @account = current_user.account_id
  #   @location_id = record.location_id
  #   @current_user_location_id = current_user.location_id
  #   ChemicalRecordMailer.urgent_email(record, @account, @location_id, @current_user_location_id).deliver
  # end

  # def need_email_alert?(record)
  #   if record.total_chlorine_ppm < 1 || record.total_chlorine_ppm > 5 then
  #     true
  #   elsif record.ph < 6.8 || record.ph > 8.2 then
  #     true
  #   else
  #     false
  #   end
  # end
end
