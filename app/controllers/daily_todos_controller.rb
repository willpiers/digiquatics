class DailyTodosController < ApplicationController
  before_action :set_daily_todo, only: [:show, :edit, :update, :destroy]

  # GET /daily_todos
  # GET /daily_todos.json
  def index
    @daily_todos = DailyTodo.all
  end

  # GET /daily_todos/1
  # GET /daily_todos/1.json
  def show
  end

  # GET /daily_todos/new
  def new
    @daily_todo = DailyTodo.new
  end

  # GET /daily_todos/1/edit
  def edit
  end

  # POST /daily_todos
  # POST /daily_todos.json
  def create
    @daily_todo = DailyTodo.new(daily_todo_params)

    respond_to do |format|
      if @daily_todo.save
        format.html { redirect_to @daily_todo, notice: 'Daily todo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @daily_todo }
      else
        format.html { render action: 'new' }
        format.json { render json: @daily_todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_todos/1
  # PATCH/PUT /daily_todos/1.json
  def update
    respond_to do |format|
      if @daily_todo.update(daily_todo_params)
        format.html { redirect_to @daily_todo, notice: 'Daily todo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @daily_todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_todos/1
  # DELETE /daily_todos/1.json
  def destroy
    @daily_todo.destroy
    respond_to do |format|
      format.html { redirect_to daily_todos_url }
      format.json { head :no_content }
    end
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
