class SlidesController < ApplicationController
  before_action :set_slide, only: [:show, :edit, :update, :destroy]

  def index
    @slides = Slide.joins(:location)
                    .where(locations: { account_id: current_user.account_id })
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
    message = 'Slide was successfully updated.'

    handle_action(@slide, message, :edit) do |resource|
      resource.update(slide_params)
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

  def handle_action(resource, message, page)
    if yield(resource)
      flash[:success] = message
      redirect_to resource
    else
      render page
    end
  end

  def slide_params
    params.require(:slide).permit(:name, :location_id)
  end
end
