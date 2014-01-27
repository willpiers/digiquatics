class PrivateLessonsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_private_lesson, only:
    [:show, :edit, :update, :destroy, :manage_private_lessons]

  def index
    @private_lessons = PrivateLesson.all
      .order(sort_column + ' ' + sort_direction)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @private_lessons}
      format.csv { render csv: @private_lessons, filename: 'private_lessons'}
    end
  end

  def admin_index
    @admin_index = PrivateLesson.joins(:user).where(user_id =! nil)
      .order(sort_column + ' ' + sort_direction)
  end

  def my_lessons
    @my_lessons = PrivateLesson.joins(:user).claimed_by(current_user)
      .order(sort_column + ' ' + sort_direction)
  end

  def manage_private_lessons
    @private_lesson = PrivateLesson.new(private_lesson_params)

    if @private_lesson.save
      flash[:success] = 'Private lesson was successfully created.'
      redirect_to @private_lesson
    else
      render 'new'
    end
  end

  def show
  end

  def new
    @private_lesson = PrivateLesson.new
  end

  def edit
  end

  def create
    @private_lesson = PrivateLesson.new(private_lesson_params)

    if @private_lesson.save
      flash[:success] = 'Private lesson was successfully created.'
      redirect_to @private_lesson
    else
      render 'new'
    end
  end

  def update
    @private_lesson.user_id = params[:user_id]

    if @private_lesson.update(private_lesson_params)
      flash[:success] = 'Private lesson was successfully updated.'
      redirect_to @private_lesson
    else
      render 'edit'
    end
  end

  def destroy
    @private_lesson.destroy
    redirect_to private_lessons_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_private_lesson
    @private_lesson = PrivateLesson.find(params[:id])
  end

  # Only allow the white list through.
  def private_lesson_params
    params.require(:private_lesson).permit(
      :first_name, :email, :last_name, :phone_number, :parent_first_name,
      :parent_last_name, :contact_method, :sex, :age, :instructor_gender,
      :notes, :day, :time, :preferred_location, :ability_level,
      :user_id, :attachment, :number_lessons )
  end

  def sort_column
    params[:sort] || 'first_name'
  end

  def sort_direction
    params[:direction] || 'asc'
  end
end
