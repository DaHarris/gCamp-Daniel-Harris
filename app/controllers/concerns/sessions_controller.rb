class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find(params[:id])
    if user
      session[:user_id] = user.id
      redirect_to root_path, :notice => 'Logged in.'
    else
      redirect_to login_path, :notice => 'Unsuccessful login.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => 'Logged out.'
  end
end
