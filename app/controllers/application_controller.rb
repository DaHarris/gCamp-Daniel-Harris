class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :admin

  def current_user
    @current_user ||= session[:user_id] && User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def admin
    if current_user && current_user.admin == true
      return true
    else
      return false
    end
  end

end
