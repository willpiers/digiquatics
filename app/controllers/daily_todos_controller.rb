class DailyTodosController < ApplicationController
  before_action :set_daily_todo, only: [:show, :edit, :update, :destroy]

  def index
    @daily_todos = DailyTodo.all
  end

  def show
  end

  def new
    @daily_todo = DailyTodo.new
  end

  def edit
  end

  def create
    @daily_todo = DailyTodo.new(daily_todo_params)
    if @daily_todo.save
      flash[:success] = 'Daily todo was successfully created.'
      redirect_to @daily_todo
    else
      render 'new'
    end
  end

  def update
    if @daily_todo.update(daily_todo_params)
      flash[:sucess] = 'Daily todo was successfully updated.'
      redirect_to @daily_todo
    else
      render 'edit'
    end
  end

  def destroy
    @daily_todo.destroy
    redirect_to daily_todos_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_daily_todo
      @daily_todo = DailyTodo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_todo_params
      params.require(:daily_todo).permit(:name, :type, :status)
    end
end
