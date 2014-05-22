class PrivateLessonsController < ApplicationController
  before_action :set_private_lesson, only:
    [:show, :edit, :update, :destroy]

  def index
    @private_lessons = PrivateLesson.joins(:account)
                       .same_account_as(current_user).unclaimed
    @participants = Participant.all
    @location = Location.all
    respond_to do |format|
      with_private_lessons_data(format, filename: 'private_lessons')
    end
  end

  def admin_index
    @admin_index = PrivateLesson.joins(:account)
                   .same_account_as(current_user).claimed
  end

  def my_lessons
    @my_lessons = PrivateLesson.joins(:user).claimed_by(current_user)
  end

  def thank_you
    render layout: 'devise'
  end

  def show
  end

  def new
    @private_lesson = Account.find(params[:account_id]).private_lessons.build
    unless current_user
      render layout: 'devise'
    end
  end

  def edit
  end

  def create
    @private_lesson = Account.find(params[:account_id]).private_lessons
    .build(private_lesson_params)
    message = 'Private lesson was successfully created.'
    @account = Account.find(@private_lesson.account_id)
    handle_action(@private_lesson, message, :new, @account, &:save)
  end

  def update
    message = 'Private lesson was successfully updated.'
    @account = @private_lesson.account
    handle_action(@private_lesson, message, :edit, @account) do |resource|
      resource.update(private_lesson_params)
    end
  end

  def destroy
    @private_lesson.destroy
    redirect_to private_lessons_url
  end

  private

  include ApplicationHelper
  include PrivateLessonsHelper

  def handle_action(resource, message, page, account)
    if signed_in?
      if yield(resource)
        flash[:success] = message
        redirect_to resource
      else
        render page
      end
    else
      redirect_to thank_you_path
    end
    thank_you_email(resource, account)
  end

  def with_private_lessons_data(format, filename: 'private_lessons')
    format.html
    format.json  { render :json => @private_lessons.to_json(:include => [:participants, :location])}
    format.csv { render csv: @private_lessons, filename: filename }
  end

  def set_private_lesson
    @private_lesson = PrivateLesson.find(params[:id])
  end

  def thank_you_email(private_lesson, account)
    PrivateLessonMailer.thank_you(private_lesson, account).deliver
  end
end
