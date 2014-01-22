class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    @locations = Location.joins(:account).same_account_as(current_user)

    respond_to do |format|
      format.html
      format.json { render json: @locations }
    end
  end

  def show
  end

  def new
    @location = Location.new
    4.times { @location.pools.build }
  end

  def edit
  end

  def create
    @location = Location.new(location_params)
    @location.account_id = current_user.account_id

    respond_to do |format|
      if @location.save
        format.html { redirect_to admin_dashboard_path,
          notice: 'Certification name was successfully created.' }
        format.json { render action: 'show', status: :created,
          location: @location }
      else
        format.html { render action: 'new' }
        format.json { render json: @location.errors,
          status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to admin_dashboard_path,
          notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors,
          status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to admin_dashboard_path }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = Location.find(params[:id])
  end

  # Only allow the white list through.
  def location_params
    params.require(:location).permit(:name, pools_attributes: [:id, :location_id, :name, :_destroy])
  end
end
