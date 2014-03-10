class ChemicalRecordsController < ApplicationController
  include ChemicalRecordsHelper
  before_action :set_chemical_record, only: [:show, :edit, :update, :destroy]

  def index
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
  end

  def new
    @chemical_record = ChemicalRecord.new
  end

  def edit
  end

  def create
    @chemical_record = ChemicalRecord.new(chemical_record_params)

    @chemical_record.si_index =
      si_index_calculator(@chemical_record.ph,
                          @chemical_record.pool_temp,
                          @chemical_record.calcium_hardness,
                          @chemical_record.alkalinity).round(2)

    @chemical_record.si_status = si_calc(@chemical_record.si_index, :status)

    @chemical_record.si_recommendation =
      si_calc(@chemical_record.si_index, :recommendation)

    @chemical_record.user_id = current_user.id

    @chemical_record.combined_chlorine_ppm =
      combined_calculator(@chemical_record.total_chlorine_ppm,
                          @chemical_record.free_chlorine_ppm)
    if @chemical_record.save
      flash[:success] = 'Chemical record was successfully created.'
      redirect_to chemical_records_path
    else
      render 'new'
    end
  end

  def update
    if @chemical_record.update(chemical_record_params)
      flash[:success] = 'Chemical record was successfully updated.'
      redirect_to @chemical_record
    else
      render 'edit'
    end
  end

  def destroy
    @chemical_record.destroy
    redirect_to chemical_records_url
  end

  private

  def set_chemical_record
    @chemical_record = ChemicalRecord.find(params[:id])
  end

  def chemical_record_params
    params.require(:chemical_record)
    .permit(:free_chlorine_ppm, :total_chlorine_ppm, :chlorine_orp, :ph,
            :alkalinity, :calcium_hardness, :pool_temp, :air_temp, :si_index,
            :time_stamp, :user_id, :pool_id, :water_clarity)
  end
end
