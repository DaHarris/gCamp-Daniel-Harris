class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
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
    if @task.save
      redirect_to task_path(@task), :notice => 'Task was successfully created.'
    else
      @messages = @task.errors.full_messages
      if @messages.length > 1
        flash[:notice] = "<strong>#{@messages.length} errors prohibited this form from being saved. </strong><br ><ul>"
        @messages.each do |x|
          flash[:notice] << "<li>#{x}</li>"
        end
        flash[:notice] << "</ul>"
      else
        flash[:notice] = "<strong>#{@messages.length} error prohibited this form from being saved. </strong><br ><ul>"
        @messages.each do |x|
          flash[:notice] << "<li>#{x}</li>"
        end
        flash[:notice] << "</ul>"
      end
      redirect_to new_task_path
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    if @task.update(task_params)
      redirect_to task_path(@task), :notice => 'Task was successfully updated.'
    else
      @messages = @task.errors.full_messages
      if @messages.length > 1
        flash[:notice] = "<strong>#{@messages.length} errors prohibited this form from being saved. </strong><br ><ul>"
        @messages.each do |x|
          flash[:notice] << "<li>#{x}</li>"
        end
        flash[:notice] << "</ul>"
      else
        flash[:notice] = "<strong>#{@messages.length} error prohibited this form from being saved. </strong><br ><ul>"
        @messages.each do |x|
          flash[:notice] << "<li>#{x}</li>"
        end
        flash[:notice] << "</ul>"
      end
      redirect_to edit_task_path(@task)
    end        
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
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
      params.require(:task).permit(:description, :date, :completed)
    end
end
