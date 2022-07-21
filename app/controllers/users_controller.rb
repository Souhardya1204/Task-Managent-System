# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_user_log_in!, except: %i[new create]
  before_action :admin_user, only: %i[index edit update]
  before_action :only_hr, only: [:approved_tasks]
  before_action :set_user, only: %i[show edit update destroy]
  before_action :correct_user, only: :show
  def new
    if Current.user
      redirect_to root_path, notice: "Already logged in"
    else
      @user = User.new
    end
  end

  def index
    @users = User.all.paginate(page: params[:page])
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

  def show; end

  def edit; end

  def update
    if @user.update_attribute("role", user_update_params[:role])
      redirect_to users_path, { notice: "User successfuly updated" }
    else
      render "edit", { alert: "Try again!!" }
    end
  end

  def mytasks
    @my_tasks = Task.my_tasks
    @high_tasks = @my_tasks.with_priority(1).paginate(page: params[:page])
    @medium_tasks = @my_tasks.with_priority(2).paginate(page: params[:page])
    @low_tasks = @my_tasks.with_priority(3).paginate(page: params[:page])
  end

  def approved_tasks
    @approved_tasks = Task.condition("acceptance", "Approved").paginate(page: params[:page])
  end

  def destroy
    @user.destroy
    redirect_to users_path, { alert: "User deleted" }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:name, :email, :role)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless Current.user.admin? || @user == Current.user
  end
end
