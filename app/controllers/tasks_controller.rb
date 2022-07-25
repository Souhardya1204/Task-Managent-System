# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :require_user_log_in!
  before_action :admin_user, only: %i[index acceptance destroy]
  before_action :set_task, except: %i[index new create search]
  before_action :task_edit_access, only: %i[edit update]
  before_action :correct_task_user, only: %i[show status category document done]
  before_action :only_hr, only: :approved_show
  def index
    @tasks = Task.includes(:user).all.paginate(page: params[:page])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Current.user.tasks.build(task_params)
    respond_to do |format|
      if @task.save
        TaskMailer.with(user: Current.user, task: @task).task_assigned.deliver_later
        format.html { redirect_to root_path, notice: "New Task Added" }
      else
        format.html { render "new" }
      end
      format.js
    end
  end

  def show
    @subtasks = @task.subtasks.paginate(page: params[:page])
  end

  def approved_show
    @subtasks = @task.subtasks
    respond_to do |format|
      format.html

      format.pdf do
        pdf = ApprovedTaskPdf.new(@task)
        send_data(pdf.render, filename: "Task_#{@task.id}.pdf",
                              type: "application/pdf", disposition: "inline")
      end
    end
  end

  def edit; end

  def update
    if @task.update(task_update_params)
      redirect_back(fallback_location: root_path, flash: { notice: "Task successfully updated" })
    else
      render "edit"
    end
  end

  def status
    @task.update_attribute(:status, params[:status])
    redirect_back(fallback_location: root_path, flash: { notice: "Task status updated" })
  end

  def category
    @task.update_attribute(:category_id, params[:task][:category_id])
    redirect_back(fallback_location: root_path, flash: { notice: "Task Category changed" })
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
        redirect_to task_path, { notice: "Task approved" }
      else
        redirect_to task_path, { alert: "Task rejected" }
      end
    else
      render "show", { alert: "Something went wrong" }
    end
  end

  def done
    @task.update_attribute(:done, params[:Done])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @task.destroy
    redirect_back(fallback_location: root_path, flash: { alert: "Task deleted" })
  end

  private

  def set_task
    @task = Task.find_by(id: params[:id])
    redirect_to root_path, alert: "Task does not exist anymore" unless @task
  end

  def task_params
    list_params_allowed = %i[name date time priority repeat employee_id category_id]
    params.require(:task).permit(list_params_allowed)
  end

  def task_update_params
    params.require(:task).permit(:name, :category_id, :date, :time, :priority, :repeat, :employee_id)
  end

  def document_params
    params.require(:task).permit(documents: [])
  end
end
