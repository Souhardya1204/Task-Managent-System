class TasksController < ApplicationController
    before_action :require_user_log_in!
    before_action :admin_user, only: [:index, :acceptance, :delete]
    before_action :correct_user, only: [:my_task]
    def index
        @tasks = Task.all.order(:priority)
    end
    def new
        @task = Task.new
    end

    def create
        @task = Current.user.tasks.build(task_params)
        if @task.save
            flash[:notice] = "New task added"
            TaskMailer.with(user: Current.user, task: @task ).task_assigned.deliver_now
            # SendReminderWorker.perform_async(@task)
            # ReminderMailer.with(task: @task).send_reminder.deliver_later
            redirect_to root_path
        else
            render "new"
        end
    end

    def show
        @task = Task.find(params[:id])
    end
    def edit
        @task = Task.find(params[:id])
        redirect_to root_path unless edit_access(@task)
    end

    def update
        @task = Task.find(params[:id])
       
        if @task.update(task_update_params)
            redirect_to tasks_path, flash: {notice: "Task successfully updated"}
        else
            render "edit"
        end
    end

    def status
        @task = Task.find(params[:id])
        if @task.update(change_status_params)
            flash[:notice] = "Task Status updated"
            redirect_back(fallback_location: root_path)
        else
            render "home", flash:{alert: "Something went wrong" }
        end

    end

    def category
        @task = Task.find(params[:id])
        if @task.update(category_params)
            redirect_to tasks_path
        else
            render "home", flash:{alert: "Something went wrong" }
        end
    end

    def acceptance
        @task = Task.find(params[:id])
        @task.acceptance = params[:value]
        if @task.save
            if @task.acceptance == "Approved"
                redirect_to task_path,{notice: "Task approved"}
            else
                redirect_to task_path,{alert: "Task rejected"}
            end
        else
            render 'show',{alert: "Something went wrong"}
        end
    end

    def destroy
        task = Task.find(params[:id])
        task.destroy
        redirect_to tasks_path, {alert: "Task deleted"}
    end

  
    private
    def task_params
        params.require(:task).permit(:name, :date, :priority, :repeat, :employee_id)
    end

    def task_update_params
        params.require(:task).permit(:name,:category, :date, :priority, :repeat, :employee_id)
    end

    def change_status_params
        params.require(:task).permit(:status)
    end

    def category_params
        params.require(:task).permit(:category)
    end

    def correct_user
        @user = User.find(params[:id])
        redirect_to root_path unless @user == Current.user
    end

    def edit_access(task)
        if Current.user.is_admin? || (Current.user == task.user )
            return true 
        else
            return false
        end
    end
end
