class CommentsController < ApplicationController

  def new
  end

  def create
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:task_id])
    @comment = Comment.new(comment_params)
    @comment.update(task_id: @task.id, user_id: current_user.id)
    if @comment.save
      redirect_to project_task_path(@project, @task)
    else
      redirect_to project_task_path(@project, @task)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

end
