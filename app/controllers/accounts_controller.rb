class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  def admin_dashboard
    @locations = Location.joins(:account)
      .where(account_id: current_user.account_id)
    @positions = Position.joins(:account)
      .where(account_id: current_user.account_id)
    @certification_names = CertificationName.joins(:account)
      .where(account_id: current_user.account_id)
   @account = Account.find(current_user.account_id)
  end

  # POST /accounts
  # POST /accounts.json
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

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
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

  # DELETE /accounts/1
  # DELETE /accounts/1.json
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
    params.require(:account).permit(:name, :time_zone)
  end
end
