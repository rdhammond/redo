class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    if params[:search]
      @tasks = Task.where("description LIKE ?", "%#{params[:search]}%")
    else
      @tasks = Task.all
    end

    respond_to do |format|
      format.html { render :index, tasks: @tasks }
      format.json { render :index, tasks: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    respond_to do |format|
      format.html { render :show, task: @task }
      format.json { render :show, task: @task }
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { render :show, task: @task }
        format.json { render :show, task: @task }
      else
        format.html { render :error, errors: @task.errors }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { render "shared/card", task: @task }
        format.json { render :show, task: @task }
      else
        format.html { render :error, errors: @task.errors }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
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
