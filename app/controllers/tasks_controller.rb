class TasksController < ApplicationController
  before_action :require_json
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1.json
  def show
  end

  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    if @task.save
      format.json { render :show, status: :created, location: @task }
    else
      format.json { render json: @task.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /tasks/1.json
  def update
    if @task.update(task_params)
      format.json { render :show, status: :ok, location: @task }
    else
      format.json { render json: @task.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    format.json { head :no_content }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :type, :done)
    end

    def require_json
      respond_to :json
    end
end
