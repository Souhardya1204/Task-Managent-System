# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    if session[:user_id]
      @user = Current.user
      @my_tasks = Task.my_tasks.order(created_at: :desc)
      @high_tasks = @my_tasks.with_priority(1)
      @medium_tasks = @my_tasks.with_priority(2)
      @low_tasks = @my_tasks.with_priority(3)
      @created_tasks = if @user.tasks.empty?
                         nil
                       else
                         @user.tasks.order(created_at: :desc)
                       end
    end
  end
end
