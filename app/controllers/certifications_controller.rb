class CertificationsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_certification, only: [:show, :edit, :update, :destroy]
  # before_action :admin, only: [:index]

  # GET /certifications
  # GET /certifications.json
  def index
    @certification_names = CertificationName.joins(:account)
      .where(account_id: current_user.account_id)
    @users = User.joins(:account).where(account_id: current_user.account_id)
      .where(active: true)
      .includes(:certifications)
      .order(sort_column + " " + sort_direction)
    @certifications = Certification.all
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @certifications}
        format.csv { render csv: @certifications, filename: 'certifications'}
      end
  end

  # GET /certifications/1
  # GET /certifications/1.json
  def show
  end

  # GET /certifications/new
  def new
    @certification = Certification.new
  end

  # GET /certifications/1/edit
  def edit
  end

  # POST /certifications
  # POST /certifications.json
  def create
    @certification = Certification.new(certification_params)

    respond_to do |format|
      if @certification.save
        format.html { redirect_to @certification,
          notice: 'Certification was successfully created.' }
        format.json { render action: 'show', status: :created,
          location: @certification }
      else
        format.html { render action: 'new' }
        format.json { render json: @certification.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /certifications/1
  # PATCH/PUT /certifications/1.json
  def update
    respond_to do |format|
      if @certification.update(certification_params)
        format.html { redirect_to @certification,
          notice: 'Certification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @certification.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # DELETE /certifications/1
  # DELETE /certifications/1.json
  def destroy
    @certification.destroy
    respond_to do |format|
      format.html { redirect_to certifications_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_certification
    @certification = Certification.find(params[:id])
  end

  # Only allow the white list through.
  def certification_params
    params.require(:certification).permit(:certification_name_id, :user_id,
      :expiration_date)
  end

  #Sorting
  def sort_column
    params[:sort] || "last_name"
  end

  def sort_direction
    params[:direction] || "asc"
  end
end
