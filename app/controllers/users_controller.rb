class UsersController < ApplicationController
  before_action :authenticate, except: [:new, :create]
  before_action :owner, only: [:edit, :update, :destroy]

  # def register
  #   @user = User.new
  # end
  #
  # def create_user
  #   @user = User.new(registered_params)
  #   if @user.save
  #     redirect_to root_path, :notice => 'User was successfully created.'
  #   else
  #     redirect_to signup_path, :notice => 'User creation was unsuccessful.'
  #   end
  # end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      if @user.save
        session[:user_id] = @user.id
        redirect_to new_project_path, :notice => "User was successfully created."
      else
        render :new
      end
    else
      @messages = @user.errors.full_messages
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
      redirect_to new_user_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, :notice => "User was successfully updated."
    else
      @messages = @user.errors.full_messages
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
    redirect_to edit_user_path(@user)
    end
  end

  private

  def owner
    @user = User.find(params[:id])
    if current_user != @user
      render :file => "#{Rails.root}/public/404.html",  :status => 404, :layout => false
    end
  end

  def authenticate
    if current_user == nil
      session[:requested_page] = request.fullpath
      redirect_to signin_path, :notice => 'Must be signed in to access.'
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
