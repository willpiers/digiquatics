class PoolsController < ApplicationController
  before_action :set_pool, only: [:show, :edit, :update, :destroy]

  def index
    @pools = Pool.same_location_as(current_user)
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

  def set_pool
    @pool = Pool.find(params[:id])
  end

  def pool_params
    params.require(:pool).permit(:name, :location_id)
  end
end
