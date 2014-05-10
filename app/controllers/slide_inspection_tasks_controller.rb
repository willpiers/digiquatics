class SlideInspectionTasksController < ApplicationController
  before_action :set_slide_inspection_tasks, only: [:show, :edit, :update, :destroy]

  def new
    @slide_inspection_task = SlideInspectionTask.new
  end

  def create
    @slide_inspection_task = SlideInspectionTask.new(slide_inspection_task_params)

    if @slide_inspection_task.save
      flash[:sucess] = 'Slide Inspection was successfully created.'
      redirect_to @slide_inspection_task
    else
      render action: 'new'
    end
  end

  private

  def set_slide_inspection
    @slide_inspection_task = SlideInspectionTask.find(params[:id])
  end

  def slide_inspection_params
    params.require(:slide_inspection_task).permit(SLIDE_INSPECTION_TASK_PARAMS)
  end
end
