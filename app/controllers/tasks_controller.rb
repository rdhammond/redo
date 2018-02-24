class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks
  # GET /tasks.json
  def index
    search = params[:search]
    if search
      @tasks = Task.where("description LIKE ?", "%#{search}%")
    else
      @tasks = Task.all
    end

    respond_to do |format|
      format.js
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @task }
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.done = false

    if @task.save
      respond_to do |format|
        format.html { render partial: 'task', content_type: 'text/html', locals: {task: @task} }
        format.json { render json: @task }
      end
    else
      respond_to do |format|
        format.html { render :error }
        format.json { render json: @task, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks
  # PATCH/PUT /tasks/1.json
  def update
  end

  # DELETE /tasks/1.json
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :task_type, :done)
    end
end
