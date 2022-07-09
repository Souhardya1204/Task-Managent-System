class StaticPagesController < ApplicationController
    def home
        if session[:user_id]
            @user = Current.user
            @my_tasks = Task.my_tasks
            @high_tasks = @my_tasks.with_priority(1)
            @medium_tasks = @my_tasks.with_priority(2)
            @low_tasks = @my_tasks.with_priority(3)
            if @user.tasks.empty?
                @created_tasks = nil
            else
                @created_tasks = @user.tasks.order(created_at: :desc)
            end
        end
    end
end