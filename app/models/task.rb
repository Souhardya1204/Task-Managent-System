# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user
  validates :employee_id, :name, :priority, presence: true
  has_many_attached :documents
  has_many :subtasks, dependent: :destroy
  enum status: { Pending: "Pending", "In Progress": "In Progress", Completed: "Completed" }
  enum priority: { High: 1, Medium: 2, Low: 3 }
  enum category: { Exams: "Exams", Birthday: "Birthday", Campus: "Campus", "Mock Test": "Mock Test",
                   Interview: "Interview", Event: "Event", Hiring: "Hiring" }
  scope :my_tasks, -> { where(employee_id: Current.user.id) }
  scope :with_priority, ->(priority) { where("priority = ?", priority) }
  def self.task_specific_statuses(task)
    if task.done
      Task.statuses
    else
      Task.statuses.reject { |k, _v| k == "Completed" }
    end
  end
end
