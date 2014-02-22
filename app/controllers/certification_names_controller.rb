class CertificationNamesController < ApplicationController
  before_action :set_certification_name,
                only: [:show, :edit, :update, :destroy]

  def index
    @certification_names = CertificationName.joins(:account)
    .same_account_as(current_user)
  end

  def show
  end

  def new
    @certification_name = CertificationName.new
  end

  def edit
  end

  def create
    @certification_name = CertificationName.new(certification_name_params)
    @certification_name.account_id = current_user.account_id

    if @certification_name.save
      redirect_to admin_dashboard_path,
                  notice: 'Certification name was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @certification_name.update(certification_name_params)
      redirect_to admin_dashboard_path,
                  notice: 'Certification name was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @certification_name.destroy
    redirect_to admin_dashboard_path
  end

  private

  def set_certification_name
    @certification_name = CertificationName.find(params[:id])
  end

  def certification_name_params
    params.require(:certification_name).permit(:name)
  end
end
