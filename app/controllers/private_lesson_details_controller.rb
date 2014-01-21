class PrivateLessonDetailsController < ApplicationController
  before_action :set_private_lesson_detail, only: [:show, :edit, :update, :destroy]

  # GET /private_lesson_details
  # GET /private_lesson_details.json
  def index
    @private_lesson_details = PrivateLessonDetail.all
  end

  # GET /private_lesson_details/1
  # GET /private_lesson_details/1.json
  def show
  end

  # GET /private_lesson_details/new
  def new
    @private_lesson_detail = PrivateLessonDetail.new
  end

  # GET /private_lesson_details/1/edit
  def edit
  end

  # POST /private_lesson_details
  # POST /private_lesson_details.json
  def create
    @private_lesson_detail = PrivateLessonDetail.new(private_lesson_detail_params)

    respond_to do |format|
      if @private_lesson_detail.save
        format.html { redirect_to admin_dashboard_path, notice: 'Private lesson detail was successfully created.' }
        format.json { render action: 'show', status: :created, location: @private_lesson_detail }
      else
        format.html { render action: 'new' }
        format.json { render json: @private_lesson_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /private_lesson_details/1
  # PATCH/PUT /private_lesson_details/1.json
  def update
    respond_to do |format|
      if @private_lesson_detail.update(private_lesson_detail_params)
        format.html { redirect_to admin_dashboard_path, notice: 'Private lesson detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @private_lesson_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /private_lesson_details/1
  # DELETE /private_lesson_details/1.json
  def destroy
    @private_lesson_detail.destroy
    respond_to do |format|
      format.html { redirect_to private_lesson_details_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_private_lesson_detail
      @private_lesson_detail = PrivateLessonDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def private_lesson_detail_params
      params.require(:private_lesson_detail).permit!
    end
end
