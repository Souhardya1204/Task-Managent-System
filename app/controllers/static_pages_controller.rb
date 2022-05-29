class StaticPagesController < ApplicationController
    def home
        if session[:user_id]
            @user = User.find_by(id: session[:user_id])
            @my_tasks = Task.where(employee_id: session[:user_id]).order(:priority)
            @high_tasks = Task.where(employee_id: session[:user_id], priority: 1)
            @medium_tasks = Task.where(employee_id: session[:user_id], priority: 2)
            @low_tasks = Task.where(employee_id: session[:user_id], priority: 3)
            if @user.tasks.empty?
                @created_tasks = nil
            else
                @created_tasks = @user.tasks
            end
        end
    end
end