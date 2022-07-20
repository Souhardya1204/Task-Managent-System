# frozen_string_literal: true

module ApplicationHelper
  def category_name(task)
    if task.category
      task.category.name
    else
      "Not specified"
    end
  end

  def check_nil(prop)
    return prop unless prop.nil?

    "Not specified"
  end

  def task_employee_name(task)
    User.find(task.employee_id).name
  end

  def task_from_notification(notification)
    Task.find_by(id: notification.task_id)&.name
  end
end
