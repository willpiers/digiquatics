class PreventativeListsController < ApplicationController
  before_action :set_preventative_list, only: [:show, :edit, :update, :destroy]

  def index
    @preventative_lists = PreventativeList.all
  end

  def show
  end

  def new
    @preventative_list = PreventativeList.new
  end

  def edit
  end

  def create
    @preventative_list = PreventativeList.new(preventative_list_params)

    if @preventative_list.save
      flash[:success] = 'Preventative list was successfully created.'
      redirect_to @preventative_list
    else
      render 'new'
    end
  end

  def update
    if @preventative_list.update(preventative_list_params)
      flash[:success] = 'Preventative list was successfully updated.'
      redirect_to @preventative_list
    else
      render 'edit'
    end
  end

  def destroy
    @preventative_list.destroy

    redirect_to preventative_lists_url
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
