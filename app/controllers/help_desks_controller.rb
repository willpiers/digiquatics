class HelpDesksController < ApplicationController
  before_action :set_help_desk, only: [:show, :edit, :update, :destroy]

  def index
    @help_desks = HelpDesk.order(sort_column + " " + sort_direction)
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @help_desks}
        format.csv { render :csv => @help_desks, filename: 'issues'}
      end
  end

  def show
  end

  def closed_index
    @helpdesk = HelpDesk.all
  end

  def new
    @help_desk = HelpDesk.new
  end

  def edit
  end

  def create
    @help_desk = HelpDesk.new(help_desk_params)
    @help_desk.user_id = current_user.id
    @help_desk.location_id = current_user.location_id

    if @help_desk.save
      flash[:success] = 'Help desk was successfully created.'
      redirect_to help_desks_path
    else
      render 'new'
    end
  end

  def update
    if @help_desk.update(help_desk_params)
      flash[:success] = 'Help desk was successfully updated.'
      redirect_to @help_desk
    else
      render 'edit'
    end
  end

  def destroy
    @help_desk.destroy

    redirect_to help_desks_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_help_desk
      @help_desk = HelpDesk.find(params[:id])
    end

    # Never trust parameters from the scary internet
    def help_desk_params
      params.require(:help_desk).permit(:name, :description, :urgency, :user_id,
                                        :location_id, :issue_status,
                                        :issue_resolution_description,
                                        :help_desk_attachment)
    end

    def sort_column
      params[:sort] || 'name'
    end

    def sort_direction
      params[:direction] || 'asc'
    end

end
