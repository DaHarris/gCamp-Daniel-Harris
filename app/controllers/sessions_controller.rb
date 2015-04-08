class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if session[:requested_page]
        redirect_to session[:requested_page], :notice => 'Logged in.'
      else
        redirect_to projects_path, :notice => 'Logged in.'
      end
    else
      redirect_to signin_path, :notice => 'Unsuccessful login.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => 'Logged out.'
  end
end
