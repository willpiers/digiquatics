class SlideInspectionsController < ApplicationController
  before_action :set_slide_inspection, only: [:show, :edit, :update, :destroy]

  def index
    @slide_inspections = SlideInspection.all
  end

  def show
  end

  def new
    @slide_inspection = SlideInspection.new
  end

  def edit
  end

  def create
    @slide_inspection = SlideInspection.new(slide_inspection_params)

    if @slide_inspection.save
      flash[:sucess] = 'Slide Inspection was successfully created.'
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

  def set_slide_inspection
    @slide_inspection = SlideInspection.find(params[:id])
  end

  def slide_inspection_params
    params.require(:slide_inspection).permit(:slide_id, :user_id)
  end
end
