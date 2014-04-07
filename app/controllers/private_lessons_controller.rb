class PrivateLessonsController < ApplicationController
  before_action :set_private_lesson, only:
    [:show, :edit, :update, :destroy]

  def index
    @private_lessons = PrivateLesson.joins(:account)
                       .same_account_as(current_user).unclaimed
    respond_to do |format|
      format.html
      format.json
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

    handle_action(@private_lesson, message, :new, &:save)
  end

  def update
    message = 'Private lesson was successfully updated.'

    handle_action(@private_lesson, message, :edit) do |resource|
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

  def handle_action(resource, message, page)
    if yield(resource)
      flash[:success] = message
      redirect_to resource
    else
      render page
    end
  end

  def with_private_lessons_data(format, filename: 'private_lessons')
    format.html
    format.csv { render csv: @private_lessons, filename: filename }
  end

  def set_private_lesson
    @private_lesson = PrivateLesson.find(params[:id])
  end
end
