# frozen_string_literal: true

class ApprovedTaskPdf < Prawn::Document
  include ApplicationHelper
  def initialize(task)
    super()
    @task = task
    task_number
    task_item
    subtask_header
    subtasks_table
  end

  def task_number
    text "Task_#{@task.id} Details", size: 24, style: :bold, position: :center
  end

  def task_item
    move_down 20
    table([["Task Name", @task.name], ["Task Category", category_name(@task)],
           ["Required on", @task.date.to_s], ["Created By", @task.user.name],
           ["Assigned to", task_employee_name(@task)]], position: :center, width: 500) do
      (0..4).each do |i|
        style(row(i).column(0), font_style: :bold)
      end
    end
  end

  def subtask_header
    move_down 40
    text "All Subtasks", size: 16, style: :bold
  end

  def subtasks_table
    move_down 20
    table subtasks_table_rows, position: :center, width: 500 do
      row(0).font_style = :bold
    end
  end

  def subtasks_table_rows
    [%w[Title Description Done]] +
      @task.subtasks.map do |item|
        [item.title, item.description, item.complete.to_s]
      end
  end
end
