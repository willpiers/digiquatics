class CertificationNamesController < ApplicationController
  before_action :set_certification_name, only: [:show, :edit, :update, :destroy]

  # GET /certification_names
  # GET /certification_names.json
  def index
    @certification_names = CertificationName.all
  end

  # GET /certification_names/1
  # GET /certification_names/1.json
  def show
  end

  # GET /certification_names/new
  def new
    @certification_name = CertificationName.new
  end

  # GET /certification_names/1/edit
  def edit
  end

  # POST /certification_names
  # POST /certification_names.json
  def create
    @certification_name = CertificationName.new(certification_name_params)

    respond_to do |format|
      if @certification_name.save
        format.html { redirect_to @certification_name, notice: 'Certification name was successfully created.' }
        format.json { render action: 'show', status: :created, location: @certification_name }
      else
        format.html { render action: 'new' }
        format.json { render json: @certification_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /certification_names/1
  # PATCH/PUT /certification_names/1.json
  def update
    respond_to do |format|
      if @certification_name.update(certification_name_params)
        format.html { redirect_to @certification_name, notice: 'Certification name was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @certification_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /certification_names/1
  # DELETE /certification_names/1.json
  def destroy
    @certification_name.destroy
    respond_to do |format|
      format.html { redirect_to certification_names_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_certification_name
      @certification_name = CertificationName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def certification_name_params
      params.require(:certification_name).permit(:account_id, :name)
    end
end
