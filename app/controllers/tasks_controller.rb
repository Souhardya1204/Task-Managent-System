class TasksController < ApplicationController
    before_action :require_user_log_in!
    before_action :admin_user, only: [:index, :acceptance, :delete]
    before_action :correct_user, only: [:my_task]
    before_action :set_task, except: [:index, :new, :create, :search]
    def index
        @tasks = Task.includes(:user).all.order(:priority)
    end
    def new
        @task = Task.new
    end

    def create
        @task = Current.user.tasks.build(task_params)
        respond_to do |format|
            if @task.save
                TaskMailer.with(user: Current.user, task: @task ).task_assigned.deliver_later
                format.html{redirect_to root_path, notice: "New Task Added"}
                format.js
            else
                format.html{render "new"}
                format.js
            end

        end
    end

    def show
       @subtasks = @task.subtasks.order(created_at: :desc)
    end

    def approved_show
         @subtasks = @task.subtasks
         respond_to do |format|
            format.html 
      
            format.pdf do
              pdf = ApprovedTaskPdf.new(@task)
              send_data pdf.render,
                filename: "Task_#{ @task.id }.pdf",
                type: 'application/pdf',
                disposition: 'inline'
            end
          end
    end
    def edit
        redirect_to root_path unless edit_access(@task)
    end

    def update
        if @task.update(task_update_params)
            redirect_back(fallback_location: root_path,flash: {notice: "Task successfully updated"})
        else
            render "edit"
        end
    end

    def status
        @task.update_attribute(:status, params[:status])
        flash[:notice] = "Task status updated"
        redirect_back(fallback_location: root_path)

    end

    def category
        @task.update_attribute(:category, params[:category])
    end

    def document
        if @task.update(document_params)
            flash[:notice] = "File uploaded"
        else
            flash[:alert] = "Something went wrong"
        end
        redirect_back(fallback_location: root_path)
    end

    def acceptance
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

    def done
        @task.update_attribute(:done, params[:Done])
        redirect_back(fallback_location: root_path)
    end

    def destroy
        @task.destroy
        redirect_back(fallback_location: root_path,flash: {alert: "Task deleted"})
    end
  
    private
    def set_task
        @task = Task.find_by(id: params[:id])
        unless @task
            redirect_to root_path, alert: "Task does not exist anymore"
        end
    end
    def task_params
        list_params_allowed = [:name, :date, :time, :priority, :repeat, :employee_id]
        list_params_allowed << :category if Current.user.is_admin?
        params.require(:task).permit(list_params_allowed)
    end

    def task_update_params
        params.require(:task).permit(:name,:category, :date, :time, :priority, :repeat, :employee_id)
    end

    def document_params
        params.require(:task).permit(documents: [])
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
