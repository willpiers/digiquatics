class SlideInspectionsController < ApplicationController
  before_action :set_slide_inspection, only: [:show, :edit, :update, :destroy]

  def index
    @slide_inspections = SlideInspection.all

    respond_to do |format|
      format.html
      format.json

      format.csv do
        render csv: @slide_inspections, filename: 'slide_inspections'
      end
    end
  end

  def show
    @errors = @slide_inspection.slide_inspection_tasks.where(completed: false)
  end

  def new
    @slide_inspection = SlideInspection.new
    @slide_inspection.slide_inspection_tasks.build
  end

  def edit
  end

  def create
    @slide_inspection = SlideInspection.new(slide_inspection_params)
    @slide_inspection.user_id = current_user.id
    @slide_inspection.all_ok = true if count_completed(slide_inspection_params) == 24
    if @slide_inspection.save
      flash[:success] = 'Slide Inspection was successfully created.'
      redirect_to @slide_inspection
    else
      render action: 'new'
    end
  end

  def update
    if @slide_inspection.update(slide_inspection_params)
      flash[:success] = 'Slide Inspection was successfully updated.'
      redirect_to @slide_inspection
    else
      render action: 'edit'
    end
  end

  def destroy
    @slide_inspection.destroy
    redirect_to slide_inspections_url
  end

  private

  include SlideInspectionsHelper

  def set_slide_inspection
    @slide_inspection = SlideInspection.find(params[:id])
  end

  def slide_inspection_params
    params.require(:slide_inspection).permit(SLIDE_INSPECTION_PARAMS)
  end
end
