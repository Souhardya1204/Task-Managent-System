class TasksController < ApplicationController
    before_action :require_user_log_in!
    before_action :admin_user, only: [:index, :edit, :approve_task, :reject_task]
    before_action :correct_user, only: [:my_task]
    def index
        @tasks = Task.all
    end
    def new
        @task = Task.new
    end

    def create
        @task = Current.user.tasks.build(task_params)
        if @task.save
            flash[:notice] = "New task added"
            redirect_to root_path
        else
            render "new"
        end
    end

    def my_task
        @mytasks = Task.where(employee_id: params[:id])
    end
    def show
        @task = Task.find(params[:id])
    end
    def edit
        @task = Task.find(params[:id])
    end

    def update
        @task = Task.find(params[:id])
       
        if @task.update(task_update_params)
            redirect_to tasks_path, flash: {notice: "Task successfully updated"}
        else
            render "edit"
        end
    end

    def new_status
        @task = Task.find(params[:id])
    end

    def change_status
        @task = Task.find(params[:id])
        @user = User.find(@task.employee_id)
        if @task.update(change_status_params)
            redirect_to mytasks_path(id: @user.id), flash: {notice: "Task status updated"}
        else
            render "new_status", flash:{alert: "Something went wrong" }
        end

    end

    def acceptance
        @task = Task.find(params[:id])
        @task.acceptance = params[:value]
        if @task.save
            redirect_to tasks_path,{notice: "Task approved"}
        else
            render 'show',{alert: "Something went wrong"}
        end
    end

  
    private
    def task_params
        params.require(:task).permit(:name, :date, :repeat, :employee_id)
    end

    def task_update_params
        params.require(:task).permit(:name,:category, :date, :repeat, :employee_id)
    end

    def change_status_params
        params.require(:task).permit(:status)
    end

    def correct_user
        @user = User.find(params[:id])
        redirect_to root_path unless @user == Current.user
    end
end
