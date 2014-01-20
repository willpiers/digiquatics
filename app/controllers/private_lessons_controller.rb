class PrivateLessonsController < ApplicationController
  before_action :set_private_lesson, only: [:show, :edit, :update, :destroy,
    :manage_private_lessons]

  # GET /private_lessons
  # GET /private_lessons.json
  def index
    @private_lessons = PrivateLesson.all
      .order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @private_lessons}
      format.csv { render csv: @private_lessons, filename: 'private_lessons'}
    end
  end

  def admin_index
    @admin_index = PrivateLesson.joins(:user).where(user_id =! nil)
      .order(sort_column + " " + sort_direction)
  end

  def my_lessons
    @my_lessons = PrivateLesson.joins(:user).claimed_by(current_user)
      .order(sort_column + " " + sort_direction)
  end

  def manage_private_lessons
    @private_lesson = PrivateLesson.new(private_lesson_params)

    respond_to do |format|
      if @private_lesson.save
        format.html { redirect_to @private_lesson,
          notice: 'Private lesson was successfully created.' }
        format.json { render action: 'show', status: :created,
          location: @private_lesson }
      else
        format.html { render action: 'new' }
        format.json { render json: @private_lesson.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # GET /private_lessons/1
  # GET /private_lessons/1.json
  def show
  end

  # GET /private_lessons/new
  def new
    @private_lesson = PrivateLesson.new
    #render layout: 'lessons_signup'
  end

  # GET /private_lessons/1/edit
  def edit
  end

  # POST /private_lessons
  # POST /private_lessons.json
  def create
    @private_lesson = PrivateLesson.new(private_lesson_params)

    respond_to do |format|
      if @private_lesson.save
        format.html { redirect_to @private_lesson,
          notice: 'Private lesson was successfully created.' }
        format.json { render action: 'show', status: :created,
          location: @private_lesson }
      else
        format.html { render action: 'new' }
        format.json { render json: @private_lesson.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /private_lessons/1
  # PATCH/PUT /private_lessons/1.json
  def update

      @private_lesson.user_id = params[:user_id]


    respond_to do |format|
      if @private_lesson.update(private_lesson_params)
        format.html { redirect_to @private_lesson,
          notice: 'Private lesson was successfully updated.' }
        format.js
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @private_lesson.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # DELETE /private_lessons/1
  # DELETE /private_lessons/1.json
  def destroy
    @private_lesson.destroy
    respond_to do |format|
      format.html { redirect_to private_lessons_url }
      format.json { head :no_content }
    end
  end

  # def claim!(current_user)
  #   @private_lesson =
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_private_lesson
      @private_lesson = PrivateLesson.find(params[:id])
    end

    # Only allow the white list through.
    def private_lesson_params
      params.require(:private_lesson).permit(:first_name, :email, :last_name,
                                              :phone_number, :parent_first_name,
                                              :parent_last_name, :contact_method,
                                              :sex, :age, :instructor_gender,
                                              :notes, :day, :time,
                                              :preferred_location, :ability_level,
                                              :user_id, :attachment,
                                              :number_lessons )
    end

  private

  def sort_column
    params[:sort] || "first_name"
  end

  def sort_direction
    params[:direction] || "asc"
  end
end
