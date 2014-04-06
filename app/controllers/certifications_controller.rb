class CertificationsController < ApplicationController
  before_action :set_certification, only: [:show, :edit, :update, :destroy]

  def index
    @certification_names = CertificationName.joins(:account)
    .same_account_as(current_user)

    @users = User.joins(:account).same_account_as(current_user).active
    .includes(:certifications)

    respond_to do |format|
      format.html #do
      #   unless Rails.env.test?
      #     Tracker.track(current_user.id, 'View Certification\'s Index')
      #   end
      # end
      format.csv { render csv: @users, filename: 'certifications' }
    end
  end

  def expirations
    render json: {
      users:               users_certification_expiration_data,
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

    if @certification.save
      redirect_to @certification,
                  notice: 'Certification was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @certification.update(certification_params)
      redirect_to @certification,
                  notice: 'Certification was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @certification.destroy
    redirect_to certifications_url
  end

  private

  include CertificationsHelper

  def set_certification
    @certification = Certification.find(params[:id])
  end

  def certification_params
    params.require(:certification)
    .permit(:certification_name_id, :user_id, :issue_date, :expiration_date,
            :attachment)
  end
end
