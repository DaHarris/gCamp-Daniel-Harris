class MembershipsController < ApplicationController

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
      redirect_to project_memberships_path(@project), notice: "Membership was successfully updated."
    elsif params[:membership][:owner] == "Member"
      @membership.update(owner: false)
      redirect_to project_memberships_path(@project), notice: "Membership was successfully updated."
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

    def membership_params
      params.require(:membership).permit(:owner)
    end
end
