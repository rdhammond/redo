class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :update, :destroy]
  before_action :task_belongs_to_current_user?, only: [:show, :update, :destroy]

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks
  # GET /tasks.json
  def index
    search = params[:search]
    if search
      @tasks = current_user.tasks.where("description LIKE ?", "%#{search}%")
    else
      @tasks = current_user.tasks
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
      format.html { render partial: 'task', content_type: 'text/html', locals: {task: @task} }
      format.json { render json: @task }
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user = current_user

    if @task.save
      respond_to do |format|
        format.html { render partial: 'task', content_type: 'text/html', locals: {task: @task} }
        format.json { render json: @task }
      end
      current_user.tasks.reload
    else
      redirect_to_error
    end
  end

  # PATCH/PUT /tasks
  # PATCH/PUT /tasks/1.json
  def update
		parameters = params[:task] ? task_params : {}
		done = params[:done]
		done = (done == "true") unless params.nil?

		if not done.nil?
			if done
				@task.complete
			else
				@task.reset
			end
			parameters[:last_completed] = @task.last_completed
			parameters[:next_refresh] = @task.next_refresh
		end

    if @task.update(parameters)
      respond_to do |format|
        format.html { render partial: 'task', content_type: 'text/html', locals: {task: @task} }
        format.json { render json: @task }
      end
    else
      redirect_to_error
    end
  end

  # DELETE /tasks/1.json
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def task_belongs_to_current_user?
      unless @task.user.id == current_user.id
        redirect_to_error
      end
    end

    def redirect_to_error
      respond_to do |format|
        format.html { render :error }
        format.json { render json: @task, status: :unprocessable_entity }
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
			params.require(:task).permit(:description, :task_type)
    end
end
