class CertificationsController < ApplicationController
  before_action :set_certification, only: [:show, :edit, :update, :destroy]

  def index
    Tracker.track(current_user.id, 'View Certs Index') unless Rails.env.test?

    @certification_names = CertificationName.joins(:account)
    .same_account_as(current_user)

    @users = User.joins(:account).same_account_as(current_user).active
    .includes(:certifications)

    certs_hash = {}

    @certification_names.each do |cert_name|
      cert_name.certifications.merge(certs_hash)
    end

    respond_to do |format|
      format.html
      format.csv { render csv: @certifications, filename: 'certifications' }
      format.json { expirations }
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
    Tracker.track(current_user.id, 'Edit Certification') unless Rails.env.test?
  end

  def create
    @certification = Certification.new(certification_params)

    if @certification.save
      Tracker.track(current_user.id, 'Create Certification') unless Rails.env.test?
      redirect_to @certification,
                  notice: 'Certification was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @certification.update(certification_params)
      Tracker.track(current_user.id, 'Update Certification') unless Rails.env.test?
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
