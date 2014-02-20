class PoolsController < ApplicationController
  before_action :set_pool, only: [:show, :edit, :update, :destroy]

  def index
    @pools = Pool.all
  end

  def user_pools
    @pools = Pool.where(location_id: current_user.location_id)

    render json: @pools.to_json
  end

  def show
  end

  def new
    @pool = Pool.new
  end

  def edit
  end

  def create
    @pool = Pool.new(pool_params)

    if @pool.save
      flash[:sucess] = 'Pool was successfully created.'
      redirect_to @pool
    else
      render action: 'new'
    end
  end

  def update
    if @pool.update(pool_params)
      flash[:success] = 'Pool was successfully updated.'
      redirect_to @pool
    else
      render action: 'edit'
    end
  end

  def destroy
    @pool.destroy
    redirect_to pools_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_pool
      @pool = Pool.find(params[:id])
    end

    # Only allow the white list through.
    def pool_params
      params.require(:pool).permit(:name, :location_id)
    end
end
