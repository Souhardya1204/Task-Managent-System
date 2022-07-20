# frozen_string_literal: true

module ApplicationHelper
  def get_string_priority(task)
    p = task.priority
    case p
    when 1
      "High"
    when 2
      "Medium"
    when 3
      "Low"
    else
      "Not specified"
    end
  end

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
end
