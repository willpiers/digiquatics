class CertificationsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_certification, only: [:show, :edit, :update, :destroy]

  def index
    @certification_names = CertificationName.joins(:account)
      .same_account_as(current_user)

    @users = User.joins(:account).same_account_as(current_user).active
      .includes(:certifications).order("#{sort_column} #{sort_direction}")

    respond_to do |format|
      format.html
      format.xml { render xml: @certifications }
      format.csv { render csv: @certifications, filename: 'certifications' }
    end
  end

  def expirations
    render json: {
      users: users_certification_expiration_data,
      certification_names: CertificationName.same_account_as(current_user)
    }
  end

  def show
  end

  def new
    @certification = Certification.new
  end

  def edit
  end

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

  def destroy
    @certification.destroy
    respond_to do |format|
      format.html { redirect_to certifications_url }
      format.json { head :no_content }
    end
  end

  private

  include CertificationsHelper

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
    params[:sort] || 'last_name'
  end

  def sort_direction
    params[:direction] || 'asc'
  end
end
