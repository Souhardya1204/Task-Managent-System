class StaticPagesController < ApplicationController
    def home
        if session[:user_id]
            @user = User.find_by(id: session[:user_id])
            @my_tasks = Task.find_by(employee_id: session[:user_id])
            if @user.tasks.empty?
                @created_tasks = nil
            else
                @created_tasks = @user.tasks
            end
        end
    end
end