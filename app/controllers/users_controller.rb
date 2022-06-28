class UsersController < ApplicationController
  before_action :require_user_log_in!, except: [:new, :create]
  before_action :admin_user, only: [:index, :edit, :update]
  before_action :only_hr, only: [:approved_tasks]
 
  def new
    if Current.user
      redirect_to root_path, notice: "Already logged in"
    else
      @user = User.new
    end
  end

  def index
    @users = User.all
  end

  def create
      @user = User.new(user_params)
      if @user.save
          session[:user_id] = @user.id
          flash[:notice] = "Successfully created account "
          redirect_to root_path
      else
          render "new"
      end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attribute('role', user_update_params[:role])
      redirect_to users_path, {notice: "User successfuly updated"}
    else
      render 'edit', {alert: "Try again!!"}
    end
  end

  def mytasks
     @my_tasks = Task.where(employee_id: params[:id])
    @high_tasks = @my_tasks.where(employee_id: session[:user_id], priority: 1)
    @medium_tasks = @my_tasks.where(employee_id: session[:user_id], priority: 2)
    @low_tasks = @my_tasks.where(employee_id: session[:user_id], priority: 3)
  end

  def approved_tasks
    @approved_tasks = Task.where( acceptance: "Approved")
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy()
    redirect_to users_path, {alert: "User deleted"}
  end

  private
  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:name, :email, :role)
  end

end
