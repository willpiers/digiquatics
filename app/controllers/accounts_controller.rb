class AccountsController < ApplicationController
  include ApplicationHelper

  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:admin_dashboard]

  def index
    @accounts = Account.all
  end

  def show
  end

  def new
    @account = Account.new
  end

  def edit
  end

  def admin_dashboard
    @locations = Location.joins(:account).same_account_as(current_user)
    @positions = Position.joins(:account).same_account_as(current_user)
    @certification_names = CertificationName.joins(:account)
      .same_account_as(current_user)
    @account = Account.find(current_user.account_id)
    @private_lesson_details = PrivateLessonDetail.all
  end

  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to admin_dashboard_path,
          notice: 'Account was successfully created.' }
        format.json { render action: 'show', status: :created,
          location: @account }
      else
        format.html { render action: 'new' }
        format.json { render json: @account.errors,
          status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to admin_dashboard_path,
          notice: 'Account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @account.errors,
          status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to admin_dashboard_path }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Only allow the white list through.
  def account_params
    params.require(:account).permit(:name, :time_zone,
                                     private_lessons_attributes: [:id])
  end
end
