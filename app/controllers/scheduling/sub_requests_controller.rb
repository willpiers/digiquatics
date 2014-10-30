class SubRequestsController < ApplicationController
  before_action :set_sub_request, only: [:show, :edit, :update, :destroy]

  include ApplicationHelper

  def index
    Tracker.track(current_user.id, 'Sub Requests Index')
    @sub_requests = SubRequest.joins(:user)
                              .where(users: { account_id: current_user.account_id })
                              .where(active: true).where(processed: false)
    respond_to do |format|
      format.html
      format.json do
        render json: @sub_requests.to_json(include: { shift: { include: [:location, :position, :user] } })
      end
    end
  end

  def show
    Tracker.track(current_user.id, 'Show Sub Request')
    @approver = User.find_by(@sub_request.processed_by_user_id)
  end

  def new
    @sub_request = SubRequest.new
  end

  def edit
    Tracker.track(current_user.id, 'Edit Sub Request')
  end

  def create
    Tracker.track(current_user.id, 'Create Sub Request')
    @sub_request = SubRequest.new(sub_request_params)

    message = 'Sub Request was successfully created.'

    handle_action(@sub_request, message, 'success', :new, &:save)
  end

  def update
    Tracker.track(current_user.id, 'Update Sub Request')

    if @sub_request.update(sub_request_params)
      render json: @sub_request.as_json
    else
      render json: @sub_request.errors, status: :unprocessable_entity
    end

  end

  def processed
    Tracker.track(current_user.id, 'View Processed Sub Requests')
    respond_to do |format|
      format.html
      format.json do
        sub_requests = SubRequest.joins(:user)
                                 .where(users: { account_id: current_user.account_id })
                                 .where(active: false).where(processed: true)
        render json: sub_requests.to_json(include: { shift: { include: [:location, :position, :user] } })
      end
    end
  end

  def admin_index
    Tracker.track(current_user.id, 'View My Sub Requests')
    respond_to do |format|
      format.html
      format.json do
        sub_requests = SubRequest.joins(:user)
                                 .where(users: { account_id: current_user.account_id })
                                 .where(active: false).where(processed: false)
        render json: sub_requests.to_json(include: { shift: { include: [:location, :position, :user] } })
      end
    end
  end

  def my_sub_requests
    respond_to do |format|
      format.html
      format.json do
        sub_requests = SubRequest.where(user_id: current_user.id)
        render json: sub_requests.to_json(include: { shift: { include: [:location, :position, :user] } })
      end
    end
    Tracker.track(current_user.id, 'View My Sub Requests')
  end

  def destroy
    @sub_request.destroy
    Tracker.track(current_user.id, 'Delete Sub Request') unless Rails.env.test?
    render :show
  end

  private

  def set_sub_request
    @sub_request = SubRequest.find(params[:id])
  end

  def sub_request_params
    params.require(:sub_request)
    .permit(:shift_id, :user_id, :sub_user_id, :sub_first_name, :sub_last_name,
            :approved, :processed_by_user_id, :processed_on, :active,
            :processed_by_last_name, :processed_by_first_name, :processed)
  end

  def handle_action(resource, message, type, page)
    if yield(resource)
      handle_shift_change(resource)
      if type == 'success' then
        flash[:success] = message
      else
        flash[:info] = message
      end
      redirect_to resource
    else
      render page
    end
  end

  def handle_shift_change(sub_request)
    if sub_request.approved?
      shift = find_sub_request_shift(sub_request)
      shift.update(user_id: sub_request.sub_user_id)
    end
  end

  def find_sub_request_shift(sub_request)
    sub_request.shift
  end
end
