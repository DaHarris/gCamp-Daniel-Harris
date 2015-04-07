class ProjectsController < ApplicationController
  before_action :authenticate

  def index
    @projects = current_user.projects
  end

  def show
    @project = Project.find(params[:id])
    redirect_to projects_path unless @project.users.include?(current_user)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      Membership.create(owner: true, user_id: current_user.id, project_id: @project.id)
      redirect_to project_tasks_path(@project), :notice => 'Project was successfully created.'
    else
      @messages = @project.errors.full_messages
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
      redirect_to new_project_path
    end
  end

  def edit
    @project = Project.find(params[:id])
    redirect_to projects_path unless @project.users.include?(current_user)
  end

  def update
    @project = Project.find(params[:id])
    redirect_to projects_path unless @project.users.include?(current_user)
    if @project.update(project_params)
      redirect_to project_path(@project), :notice => 'Project was successfully updated.'
    else
      @messages = @project.errors.full_messages
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
      redirect_to edit_project_path(@project)
    end
  end

  def destroy
    @project = Project.find(params[:id])
    redirect_to projects_path unless @project.users.include?(current_user)
    @project.destroy
    redirect_to projects_path
  end

  private

  def authenticate
    if current_user == nil
      redirect_to signin_path, :notice => 'Must be signed in to access.'
    end
  end

  def project_params
    params.require(:project).permit(:name)
  end

end
