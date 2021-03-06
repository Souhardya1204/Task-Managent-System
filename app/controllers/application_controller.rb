# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :unread_notifications
  before_action :set_query
  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_user_log_in!
    redirect_to sign_in_path, alert: "You must be signed in to do that" if Current.user.nil?
  end

  def admin_user
    redirect_to root_path unless Current.user.admin?
  end

  def only_hr
    redirect_to root_path unless Current.user.hr?
  end

  def unread_notifications
    return unless Current.user

    @unread_notifications = Current.user.notifications.unread
    @unread_count = @unread_notifications.count
  end

  def set_query
    return unless Current.user

    @q = task_list
    @search_tasks = @q.result(distinct: true).paginate(page: params[:page])
  end

  def task_list
    if Current.user.admin?
      Task.ransack(params[:q])
    else
      Task.condition("employee_id", Current.user.id).or(Current.user.tasks).ransack(params[:q])
    end
  end

  def task_edit_access
    return if Current.user.admin? || (Current.user == @task.user)

    redirect_to root_path, alert: "You are not authorized to edit the task"
  end

  def correct_task_user
    return if Current.user.admin? || (Current.user == @task.user) || Current.user.id == @task.employee_id

    redirect_to root_path, alert: "You are not authorized to access the task"
  end
end
