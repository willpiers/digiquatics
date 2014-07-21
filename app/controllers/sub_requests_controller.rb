class SubRequestsController < ApplicationController
  before_action :set_sub_request, only: [:show, :edit, :update, :destroy]

  include ApplicationHelper

  def index
    Tracker.track(current_user.id, 'Sub Requests Index') unless Rails.env.test?
    respond_to do |format|
      format.html
      format.json do
        sub_requests = SubRequest.joins(:user)
                                 .where(users: { account_id: current_user.account_id })
                                 .where(active: true)
        render json: sub_requests.to_json(include: {shift: {include: [:location, :position, :user]}})
      end
    end
  end

  def show
    Tracker.track(current_user.id, 'Show Sub Request') unless Rails.env.test?
    @approver = User.find_by(@sub_request.processed_by_user_id)
  end

  def new
    @sub_request = SubRequest.new
  end

  def edit
    Tracker.track(current_user.id, 'Edit Sub Request') unless Rails.env.test?
  end

  def create
    Tracker.track(current_user.id, 'Create Sub Request') unless Rails.env.test?
    @sub_request = SubRequest.new(sub_request_params)

    message = 'Sub Request was successfully created.'

    handle_action(@sub_request, message, :new, &:save)
  end

  def update
    Tracker.track(current_user.id, 'Update Sub Request') unless Rails.env.test?
    message = 'Sub Request was successfully updated.'
    handle_action(@sub_request, message, :edit) do |resource|
      resource.update(sub_request_params)
    end
    @sub_request? nil : approve_or_deny_logic
  end

  def processed
    Tracker.track(current_user.id, 'View Processed Sub Requests') unless Rails.env.test?
    respond_to do |format|
      format.html
      format.json do
        sub_requests = SubRequest.joins(:user)
                                 .where(users: { account_id: current_user.account_id })
                                 .where(active: false)
        render json: sub_requests.to_json(include: {shift: {include: [:location, :position, :user]}})
      end
    end
  end

  def my_sub_requests
    respond_to do |format|
      format.html
      format.json do
        my_sub_requests = SubRequest.where(user_id: current_user.id)
        render json: my_sub_requests.to_json(include: {shift: {include: [:location, :position, :user]}})
      end
    end
    Tracker.track(current_user.id, 'View My Sub Requests') unless Rails.env.test?
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
