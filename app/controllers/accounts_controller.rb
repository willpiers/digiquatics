class AccountsController < ApplicationController
  include ApplicationHelper
  include SessionsHelper

  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:admin_dashboard]

  def index
    @accounts = Account.all
  end

  def show
  end

  def new
    @account = Account.new
    @account.users.build(admin: true)
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

    if @account.save
      @user = User.find(@account.users)
      @user.admin = true
      sign_in(@user)
      flash[:success] = 'Account was successfully created.'
      redirect_to admin_dashboard_path
    else
      render 'new'
    end
  end

  def update
    if @account.update(account_params)
      flash[:success] = 'Account was successfully updated.'
      redirect_to admin_dashboard_path
    else
      render 'edit'
    end
  end

  def destroy
    @account.destroy

    redirect_to admin_dashboard_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Only allow the white list through.
  def account_params
    params.require(:account).permit(:name,
                                    :time_zone,
                                    private_lessons_attributes: [:id],
                                    users_attributes: [:id,
                                                       :first_name,
                                                       :nickname,
                                                       :last_name,
                                                       :email,
                                                       :account_id,
                                                       :password,
                                                       :password_confirmation,
                                                       :phone_number])
  end
end
