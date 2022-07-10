# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to root_path, notice: "Already logged in" if Current.user
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully"
    else
      flash[:alert] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged Out"
  end

  def omniauth
    @user = User.from_omniauth(auth)
    @user.save
    session[:user_id] = @user.id
    redirect_to root_path
  end

  private

  def auth
    request.env["omniauth.auth"]
  end
end
