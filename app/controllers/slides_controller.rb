class SlidesController < ApplicationController
  before_action :set_slide, only: [:show, :edit, :update, :destroy]

  def index
    @slides = Slide.joins(:account).same_account_as(current_user)
  end

  def show
  end

  def new
    @slide = Slide.new
  end

  def edit
  end

  def create
    @slide = Slide.new(slide_params)

    if @slide.save
      flash[:sucess] = 'Slide was successfully created.'
      redirect_to @slide
    else
      render action: 'new'
    end
  end

  def update
    if @slide.update(slide_params)
      flash[:success] = 'Slide was successfully updated.'
      redirect_to @slide
    else
      render action: 'edit'
    end
  end

  def destroy
    @slide.destroy
    redirect_to slides_url
  end

  private

  def set_slide
    @slide = slide.find(params[:id])
  end

  def slide_params
    params.require(:slide).permit(:name, :location_id)
  end
end
