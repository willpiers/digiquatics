class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    @locations = Location.joins(:account).same_account_as(current_user)
    if stale?(@locations)
      respond_to do |format|
        format.html
        format.json do
          render json: oj_dumper(@locations)
        end
      end
    end
  end

  def show
  end

  def new
    @location = Location.new
    @location.pools.build
    @location.slides.build
  end

  def edit
  end

  def create
    @location = Location.new(location_params)
    @location.account_id = current_user.account_id

    if @location.save
      flash[:success] = 'Location was successfully created.'
      redirect_to admin_dashboard_path
    else
      render 'new'
    end
  end

  def update
    if @location.update(location_params)
      flash[:info] = 'Location was successfully updated.'
      redirect_to admin_dashboard_path
    else
      render 'edit'
    end
  end

  def destroy
    @location.destroy
    redirect_to admin_dashboard_path
    flash[:error] = 'Location was successfully deleted.'
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location)
    .permit(:name, pools_attributes: [:id, :location_id, :name, :_destroy],
                   slides_attributes: [:id, :location_id, :name, :_destroy])
  end

  def oj_dumper(view)
    Oj.dump(view, mode: :compat)
  end
end
