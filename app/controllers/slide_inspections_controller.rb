class SlideInspectionsController < ApplicationController
  before_action :set_slide_inspection, only: [:show, :edit, :update, :destroy]

  def index
    @slide_inspections = SlideInspection.joins(slide: :location)
    .where(locations: { account_id: current_user.account_id })

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

  def create
    @slide_inspection = SlideInspection.new(slide_inspection_params)
    update_fields(@slide_inspection)

    if @slide_inspection.save
      create_help_desk(@slide_inspection) unless @slide_inspection.all_ok?
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

  def update_fields(slide_inspection)
    slide_inspection.user_id = current_user.id
    slide_inspection.all_ok = true if count_completed(slide_inspection_params) == 24
  end

  def create_help_desk(slide_inspection)
    create_error_string(slide_inspection)
    create_ticket(@error_string, slide_inspection)
    slide_email_alert(@error_string, slide_inspection, current_user.id)
  end

  def create_error_string(slide_inspection)
    @errors = slide_inspection.slide_inspection_tasks.where(completed: false)
    @error_string = 'Issues: '
    @errors.each do |inspection|
      @error_string << "#{inspection.task_name}; "
    end
  end

  def create_ticket(error, slide_inspection)
    HelpDesk.create!(name: "#{slide_inspection.slide.name} Slide Inspection Issue",
                     user_id: current_user.id,
                     location_id: @slide_inspection.slide.location_id,
                     description: "#{error}Employee Notes: #{slide_inspection.notes}",
                     urgency: 'High')
  end

  def slide_email_alert(error, slide_inspection, user)
    @account = current_user.account_id
    @location = current_user.location_id
    SlideMailer.urgent_slide_inspection(error, slide_inspection, @account, @location, user).deliver
  end
end
