class PrivateLessonDetailsController < ApplicationController
  before_action :set_private_lesson_detail,
                only: [:show, :edit, :update, :destroy]

  def index
    @private_lesson_details = PrivateLessonDetail.all
  end

  def show
  end

  def new
    @private_lesson_detail = PrivateLessonDetail.new
  end

  def edit
  end

  def create
    @private_lesson_detail = PrivateLessonDetail.new(
      private_lesson_detail_params)

    if @private_lesson_detail.save
      redirect_to admin_dashboard_path,
                  notice: 'Private lesson detail was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @private_lesson_detail.update(private_lesson_detail_params)
      redirect_to admin_dashboard_path,
                  notice: 'Private lesson detail was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @private_lesson_detail.destroy
    redirect_to private_lesson_details_url
  end

  private

  def set_private_lesson_detail
    @private_lesson_detail = PrivateLessonDetail.find(params[:id])
  end

  def private_lesson_detail_params
    params.require(:private_lesson_detail).permit!
  end
end
