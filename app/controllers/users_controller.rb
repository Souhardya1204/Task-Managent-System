class UsersController < ApplicationController
  before_action :require_user_log_in!, only: [:index]
  before_action :admin_user, only: :index
 
  def new
    @user = User.new
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

  private
  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
