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
end
