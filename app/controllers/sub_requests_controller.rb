class SubRequestsController < ApplicationController
  before_action :set_sub_request, only: [:show, :edit, :update, :destroy]

  include ApplicationHelper

  def index
    @sub_requests = SubRequest.joins(:user)
    .where(users: { account_id: current_user.account_id }).where(active: true)
  end

  def show
    @approver = User.find_by(@sub_request.processed_by_user_id)
  end

  def new
    @sub_request = SubRequest.new
  end

  def edit
  end

  def create
    @sub_request = SubRequest.new(sub_request_params)

    message = 'Sub Request was successfully created.'

    handle_action(@sub_request, message, :new, &:save)
  end

  def update
    message = 'Sub Request was successfully updated.'
    handle_action(@sub_request, message, :edit) do |resource|
      resource.update(sub_request_params)
    end
    @sub_request? nil : approve_or_deny_logic
  end

  def archived_sub_requests
    @archived_sub_requests = SubRequest.joins(:user)
    .where(users: { account_id: current_user.account_id }).where(active: false)
  end

  def my_sub_requests
    @my_sub_requests = SubRequest.where(user_id: current_user.id)
  end

  def destroy
    @sub_request.destroy

    redirect_to sub_requests_url
  end

  private

  def set_sub_request
    @sub_request = SubRequest.find(params[:id])
  end

  def sub_request_params
    params.require(:sub_request)
    .permit(:shift_id, :user_id, :sub_user_id, :approved,
            :processed_by_user_id, :processed_on, :active,
            :processed_by_last_name, :processed_by_first_name)
  end

  def handle_action(resource, message, page)
    if yield(resource)
      flash[:success] = message
      redirect_to resource
    else
      render page
    end
  end

  def approve_or_deny_logic
    @sub_request.processed_by_user_id = current_user.id
    @sub_request.processed_by_last_name = current_user.last_name
    @sub_request.processed_by_first_name = current_user.first_name
    @sub_request.processed_on = Time.now
  end
end
