class PreventativeListsController < ApplicationController
  before_action :set_preventative_list, only: [:show, :edit, :update, :destroy]

  # GET /preventative_lists
  # GET /preventative_lists.json
  def index
    @preventative_lists = PreventativeList.all
  end

  # GET /preventative_lists/1
  # GET /preventative_lists/1.json
  def show
  end

  # GET /preventative_lists/new
  def new
    @preventative_list = PreventativeList.new
  end

  # GET /preventative_lists/1/edit
  def edit
  end

  # POST /preventative_lists
  # POST /preventative_lists.json
  def create
    @preventative_list = PreventativeList.new(preventative_list_params)

    respond_to do |format|
      if @preventative_list.save
        format.html { redirect_to @preventative_list, notice: 'Preventative list was successfully created.' }
        format.json { render action: 'show', status: :created, location: @preventative_list }
      else
        format.html { render action: 'new' }
        format.json { render json: @preventative_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /preventative_lists/1
  # PATCH/PUT /preventative_lists/1.json
  def update
    respond_to do |format|
      if @preventative_list.update(preventative_list_params)
        format.html { redirect_to @preventative_list, notice: 'Preventative list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @preventative_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preventative_lists/1
  # DELETE /preventative_lists/1.json
  def destroy
    @preventative_list.destroy
    respond_to do |format|
      format.html { redirect_to preventative_lists_url }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_preventative_list
      @preventative_list = PreventativeList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def preventative_list_params
      params.require(:preventative_list).permit(:name, :type)
    end
end
