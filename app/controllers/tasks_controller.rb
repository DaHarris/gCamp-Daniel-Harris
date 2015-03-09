class TasksController < ApplicationController
  before_action :authenticate
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = @project.tasks
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.project_id = @project.id
    if @task.save
      redirect_to project_task_path(@project, @task), :notice => 'Task was successfully created.'
    else
      @messages = @task.errors.full_messages
      if @messages.length > 1
        flash[:danger] = "<h2>#{@messages.length} errors prohibited this form from being saved. </h2><br ><ul>"
        @messages.each do |x|
          flash[:danger] << "<li>#{x}</li>"
        end
        flash[:danger] << "</ul>"
      else
        flash[:danger] = "<h2>#{@messages.length} error prohibited this form from being saved. </h2><br ><ul>"
        @messages.each do |x|
          flash[:danger] << "<li>#{x}</li>"
        end
        flash[:danger] << "</ul>"
      end
      redirect_to new_project_task_path(@project)
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    if @task.update(task_params)
      redirect_to project_task_path(@project, @task), :notice => 'Task was successfully updated.'
    else
      @messages = @task.errors.full_messages
      if @messages.length > 1
        flash[:danger] = "<h2>#{@messages.length} errors prohibited this form from being saved. </h2><br ><ul>"
        @messages.each do |x|
          flash[:danger] << "<li>#{x}</li>"
        end
        flash[:danger] << "</ul>"
      else
        flash[:danger] = "<h2>#{@messages.length} error prohibited this form from being saved. </h2><br ><ul>"
        @messages.each do |x|
          flash[:danger] << "<li>#{x}</li>"
        end
        flash[:danger] << "</ul>"
      end
      redirect_to edit_project_task_path(@project, @task)
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def authenticate
    if current_user == nil
      redirect_to signin_path, :notice => 'Must be signed in to access.'
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:description, :date, :completed)
  end
end
