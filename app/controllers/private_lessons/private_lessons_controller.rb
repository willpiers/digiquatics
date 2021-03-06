class PrivateLessonsController < ApplicationController
  before_action :set_private_lesson, only:
    [:show, :edit, :update, :destroy]

  def index
    Tracker.track(current_user.id, 'Private Lessons Index')
    @private_lessons = PrivateLesson.joins(:account)
                       .same_account_as(current_user).unclaimed
    @participants = Participant.all
    @location = Location.all
    respond_to do |format|
      with_private_lessons_data(format, filename: 'private_lessons')
    end
  end

  def admin_index
    Tracker.track(current_user.id, 'Private Lessons Admin Index')
    @admin_index = PrivateLesson.joins(:account)
                   .same_account_as(current_user)
                   .where(completed_on: nil).claimed
    @participants = Participant.all
    @location = Location.all
    @users = User.all
    respond_to do |format|
      format.html
      format.json  { render json: @admin_index.to_json(include: [:participants, :location, :user]) }
    end
  end

  def completed_admin_index
    Tracker.track(current_user.id, 'Private Lessons Completed Admin Index')
    @admin_index = PrivateLesson.joins(:account)
                   .same_account_as(current_user).where.not(completed_on: nil)
                   .claimed
    @participants = Participant.all
    @location = Location.all
    @users = User.all
    respond_to do |format|
      format.html
      format.json  { render json: @admin_index.to_json(include: [:participants, :location, :user]) }
    end
  end

  def my_lessons
    Tracker.track(current_user.id, 'My Lessons')
    @my_lessons = PrivateLesson.joins(:user).claimed_by(current_user)
    @participants = Participant.all
    @location = Location.all
    respond_to do |format|
      format.html
      format.json  { render json: @my_lessons.to_json(include: [:participants, :location]) }
    end
  end

  def thank_you
    render layout: 'devise'
  end

  def show
  end

  def new
    @private_lesson = Account.find(params[:account_id]).private_lessons.build
    @skill_levels = SkillLevel.same_account_as(current_user || @private_lesson)
    @private_lesson.participants.build
    unless current_user
      render layout: 'devise'
    end
  end

  def edit
    Tracker.track(current_user.id, 'Edit Private Lesson')
  end

  def create
    if signed_in?
      Tracker.track(current_user.id, 'Create Private Lesson')
    end
    @private_lesson = Account.find(params[:account_id]).private_lessons
    .build(private_lesson_params)
    message = 'Private lesson was successfully created.'
    @account = Account.find(@private_lesson.account_id)
    handle_action(@private_lesson, message, 'success', :new, @account, &:save)
  end

  def update
    Tracker.track(current_user.id, 'Update Private Lesson')
    message = 'Private lesson was successfully updated.'
    @account = @private_lesson.account
    handle_action(@private_lesson, message, 'info', :edit, @account) do |resource|
      resource.update(private_lesson_params)
    end
  end

  def destroy
    @private_lesson.destroy
    redirect_to private_lessons_url
    flash[:error] = 'Private lesson was successfully deleted.'
  end

  private

  include ApplicationHelper
  include PrivateLessonsHelper

  def handle_action(resource, message, type, page, account)
    if yield(resource)
      thank_you_email(resource, account)
      if signed_in?
        if type == 'success' then
          flash[:success] = message
        else
          flash[:info] = message
        end
        redirect_to resource
      else
        redirect_to thank_you_path
      end
    else
      render page
    end
  end

  def with_private_lessons_data(format, filename: 'private_lessons')
    format.html
    format.json  { render json: @private_lessons.to_json(include: [:participants, :location]) }
    format.csv { render csv: @private_lessons, filename: filename }
  end

  def set_private_lesson
    @private_lesson = PrivateLesson.find(params[:id])
  end

  def thank_you_email(private_lesson, account)
    PrivateLessonMailer.thank_you(private_lesson, account).deliver
  end
end
