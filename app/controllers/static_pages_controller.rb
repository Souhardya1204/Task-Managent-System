# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    return unless session[:user_id]

    @user = Current.user
    @my_tasks = Task.my_tasks
    @high_tasks = @my_tasks.with_priority(1)
    @medium_tasks = @my_tasks.with_priority(2)
    @low_tasks = @my_tasks.with_priority(3)
    @created_tasks = @user.tasks unless @user.tasks.empty?
  end

  def about; end
end
