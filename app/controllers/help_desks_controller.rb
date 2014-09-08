class HelpDesksController < ApplicationController
  before_action :set_help_desk, only: [:show, :edit, :update, :destroy]

  def index
    Tracker.track(current_user.id, 'Help Desk Index') unless Rails.env.test?
    @help_desks = HelpDesk.joins(:location)
                  .where(locations: { account_id: current_user.account_id })
                  .where(issue_status: true)

    respond_to do |format|
      format.html
      format.json

      format.csv do
        render csv: @help_desks, filename: 'issues'
      end
    end
  end

  def show
    Tracker.track(current_user.id, 'Show Help Desk Issue') unless Rails.env.test?
    @facade = HelpDeskFacade.new(@help_desk)
  end

  def closed_index
    Tracker.track(current_user.id, 'View Closed Help Desk') unless Rails.env.test?
    @closed_index = HelpDesk.joins(:location)
                  .where(locations: { account_id: current_user.account_id })
                  .where(issue_status: false)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @help_desk = HelpDesk.new
  end

  def edit
    Tracker.track(current_user.id, 'Edit Help Desk Issue') unless Rails.env.test?
  end

  def create
    Tracker.track(current_user.id, 'Create Help Desk Issue') unless Rails.env.test?
    @help_desk = HelpDesk.new(help_desk_params)
    @help_desk.user_id = current_user.id

    if @help_desk.save
      flash[:success] = 'Help desk was successfully created.'
      urgent_email(@help_desk)
      redirect_to @help_desk
    else
      render 'new'
    end
  end

  def update
    Tracker.track(current_user.id, 'Update Help Desk Issue') unless Rails.env.test?
    @help_desk.closed_user_id = current_user.id
    @help_desk.closed_date_time = Time.now

    if @help_desk.update(help_desk_params)
      urgent_email(@help_desk)
      flash[:info] = 'Help desk was successfully updated.'
      redirect_to @help_desk
    else
      render 'edit'
    end
  end

  def destroy
    @help_desk.destroy
    redirect_to help_desks_url
    flash[:error] = 'Help desk was successfully deleted.'
  end

  private

  include ApplicationHelper
  include HelpDesksHelper

  def set_help_desk
    @help_desk = HelpDesk.find(params[:id])
  end

  def help_desk_params
    params.require(:help_desk)
    .permit(:name, :description, :urgency, :user_id, :location_id,
            :issue_status, :issue_resolution_description,
            :help_desk_attachment, :closed_user_id, :closed_date_time)
  end

  def urgent_email(issue)
    @account = current_user.account_id
    @location_id = issue.location_id
    @current_user_location_id = current_user.location_id
    if issue.urgency == 'High' then
      HelpDeskMailer.urgent_email(issue, @account, @location_id, @current_user_location_id).deliver
    end
  end
end
