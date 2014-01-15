class HelpDesksController < ApplicationController
  before_action :set_help_desk, only: [:show, :edit, :update, :destroy]

  # GET /help_desks
  # GET /help_desks.json
  def index
    @help_desks = HelpDesk.all
  end

  # GET /help_desks/1
  # GET /help_desks/1.json
  def show
  end

  # GET /help_desks/new
  def new
    @help_desk = HelpDesk.new
  end

  # GET /help_desks/1/edit
  def edit
  end

  # POST /help_desks
  # POST /help_desks.json
  def create
    @help_desk = HelpDesk.new(help_desk_params)

    respond_to do |format|
      if @help_desk.save
        format.html { redirect_to @help_desk, notice: 'Help desk was successfully created.' }
        format.json { render action: 'show', status: :created, location: @help_desk }
      else
        format.html { render action: 'new' }
        format.json { render json: @help_desk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /help_desks/1
  # PATCH/PUT /help_desks/1.json
  def update
    respond_to do |format|
      if @help_desk.update(help_desk_params)
        format.html { redirect_to @help_desk, notice: 'Help desk was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @help_desk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /help_desks/1
  # DELETE /help_desks/1.json
  def destroy
    @help_desk.destroy
    respond_to do |format|
      format.html { redirect_to help_desks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_help_desk
      @help_desk = HelpDesk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def help_desk_params
      params.require(:help_desk).permit(:name, :type)
    end
end
