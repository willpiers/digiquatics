class PositionsController < ApplicationController
  before_action :set_position, only: [:show, :edit, :update, :destroy]

  def index
    @positions = Position.joins(:account).same_account_as(current_user)
  end

  def show
  end

  def new
    @position = Position.new
  end

  def edit
  end

  def create
    @position = Position.new(position_params)
    @position.account_id = current_user.account_id

    if @position.save
      flash[:success] = 'Position was successfully created.'
      redirect_to admin_dashboard_path
    else
      render 'new'
    end
  end

  def update
    if @position.update(position_params)
      flash[:info] = 'Position was successfully updated.'
      redirect_to admin_dashboard_path
    else
      render 'edit'
    end
  end

  def destroy
    @position.destroy
    redirect_to admin_dashboard_path
    flash[:error] = 'Position was successfully deleted.'
  end

  private

  def set_position
    @position = Position.find(params[:id])
  end

  def position_params
    params.require(:position).permit(:name)
  end
end
