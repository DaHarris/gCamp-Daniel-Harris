class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    @project  = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project), :notice => 'Project was successfully created.'
    else
      @messages = @project.errors.full_messages
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
      redirect_to new_project_path
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to project_path(@project), :notice => 'Project was successfully updated.'
    else
      @messages = @project.errors.full_messages
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
      redirect_to edit_project_path(@project)
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
  end
  def project_params
    params.require(:project).permit(:name)
  end

end
