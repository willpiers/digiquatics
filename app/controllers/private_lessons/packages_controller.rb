class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy]

  def index
    @packages = Package.same_account_as(current_user)
  end

  def show
  end

  def new
    @package = Package.new
  end

  def edit
  end

  def create
    @package = Package.new(package_params)
    @package.account_id = current_user.account_id

    if @package.save
      flash[:success] = 'Package was successfully created.'
      redirect_to admin_dashboard_path
    else
      render 'new'
    end
  end

  def update
    if @package.update(package_params)
      flash[:info] = 'Package was successfully updated.'
      redirect_to admin_dashboard_path
    else
      render 'edit'
    end
  end

  def destroy
    @package.destroy
    redirect_to admin_dashboard_path
    flash[:error] = 'Package was successfully deleted.'
  end

  private

  def set_package
    @package = Package.find(params[:id])
  end

  def package_params
    params.require(:package).permit(:name)
  end
end
