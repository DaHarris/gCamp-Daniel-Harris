class MembershipsController < ApplicationController
  before_action :authenticate
  before_action :owner, only: [:edit, :update, :delete]

  def index
    @project = Project.find(params[:project_id])
    @memberships = @project.memberships
    @roles = ["Owner", "Member"]
  end

  def show
    @project = Project.find(params[:project_id])
    @memberships = Membership.find(params[:id])
  end

  def create
    @project = Project.find(params[:project_id])
    @membership = Membership.new(membership_params)
    if params[:membership][:owner] == "Owner"
      @membership.owner = true
    else
      @membership.owner = false
    end
    @membership.user_id = params[:membership][:user_id]
    @membership.project_id = @project.id
    if @membership.save
      redirect_to project_memberships_path(@project), notice: "Membership was successfully created."
    else
      @messages = @membership.errors.full_messages
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
      redirect_to project_memberships_path(@project)
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @membership = Membership.find(params[:id])
    if params[:membership][:owner] == "Owner"
      @membership.update(owner: true)
      if @membership.valid?
        redirect_to project_memberships_path(@project), notice: "Membership was successfully updated."
      else
        redirect_to project_memberships_path(@project), notice: @membership.errors.full_messages[0]
      end
    elsif params[:membership][:owner] == "Member"
      @membership.update(owner: false)
      if @membership.valid?
        redirect_to project_memberships_path(@project), notice: "Membership was successfully updated."
      else
        redirect_to project_memberships_path(@project), notice: @membership.errors.full_messages[0]
      end
    else
      @messages = @membership.errors.full_messages
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
      redirect_to project_memberships_path(@project)
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @membership = Membership.find(params[:id])
    @membership.destroy
    redirect_to project_memberships_path(@project), notice: "Membership was successfully destroyed."
  end

  private

  def authenticate
    @project = Project.find(params[:project_id])
    session[:requested_page] = request.fullpath
    redirect_to projects_path, notice: "You do not have access to that project" unless @project.users.include?(current_user) || admin
  end

  def owner
    @project = Project.find(params[:project_id])
    if @project.memberships.where(owner: true, user_id: current_user.id) == [] && !admin
      redirect_to @project, notice: "You do not have access"
    end
  end

  def membership_params
    params.require(:membership).permit(:owner)
  end
end
