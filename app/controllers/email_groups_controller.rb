class EmailGroupsController < ApplicationController
  include ApplicationHelper
  before_action :set_email_group, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index]

  def index
    @email_groups = EmailGroup.all
  end

  def show
  end

  def new
    @email_group = EmailGroup.new
  end

  def edit
  end

  def create
    @email_group = EmailGroup.new(email_group_params)
    @email_group.user_first_name = User.find_by_id(@email_group.user_id).first_name
    @email_group.user_last_name = User.find_by_id(@email_group.user_id).last_name
    @email_group.user_email = User.find_by_id(@email_group.user_id).email

    if @email_group.save
      redirect_to email_groups_path, notice: 'User was added to email group.'
    else
      render action: 'new'
    end
  end

  def update
    respond_to do |format|
      if @email_group.update(email_group_params)
        format.html { redirect_to @email_group, notice: 'Email group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @email_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @email_group.destroy
    respond_to do |format|
      format.html { redirect_to email_groups_url }
      format.json { head :no_content }
    end
  end

  private

  def set_email_group
    @email_group = EmailGroup.find(params[:id])
  end

  def email_group_params
    params.require(:email_group).permit(:id, :user_id, :email,
                                        :user_first_name, :user_last_name)
  end
end
