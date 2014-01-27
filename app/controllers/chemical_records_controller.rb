class ChemicalRecordsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_chemical_record, only: [:show, :edit, :update, :destroy]

  # GET /chemical_records
  # GET /chemical_records.json
  def index
    @chemical_records = ChemicalRecord.order(sort_column + " " + sort_direction)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @chemical_records}
      format.csv { render :csv => @chemical_records, filename: 'chemical_records'}
    end
  end

  # GET /chemical_records/1
  # GET /chemical_records/1.json
  def show
  end

  # GET /chemical_records/new
  def new
    @chemical_record = ChemicalRecord.new
  end

  # GET /chemical_records/1/edit
  def edit
  end

  # POST /chemical_records
  # POST /chemical_records.json
  def create
    @chemical_record = ChemicalRecord.new(chemical_record_params)

    if @chemical_record.save
      flash[:success] = 'Chemical record was successfully created.'
      redirect_to chemical_records_path
    else
      render 'new'
    end
  end

  # PATCH/PUT /chemical_records/1
  # PATCH/PUT /chemical_records/1.json
  def update
    if @chemical_record.update(chemical_record_params)
      flash[:success] = 'Chemical record was successfully updated.'
      redirect_to @chemical_record
    else
      render 'edit'
    end
  end

  # DELETE /chemical_records/1
  # DELETE /chemical_records/1.json
  def destroy
    @chemical_record.destroy
    redirect_to chemical_records_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_chemical_record
    @chemical_record = ChemicalRecord.find(params[:id])
  end

  # Only allow the white list through.
  def chemical_record_params
    params.require(:chemical_record)
      .permit(:chlorine_ppm, :chlorine_orp, :ph, :alkalinity, :calcium_hardness,
              :pool_temp, :air_temp, :si_index, :time_stamp, :date_stamp)
  end

  def sort_column
    params[:sort] || 'created_at'
  end

  def sort_direction
    params[:direction] || 'desc'
  end
end
