# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  validates :employee_id, :name, :priority, presence: true
  has_many_attached :documents
  has_many :subtasks, dependent: :destroy
  enum status: { pending: "pending", in_progress: "in progress", completed: "completed" }
  enum priority: { high: 1, medium: 2, low: 3 }
  enum repeat: { onetime: "onetime", daily: "daily", weekly: "weekly", monthly: "monthly", quarterly: "quarterly",
                 halfyearly: "halfyearly", yearly: "yearly" }
  default_scope { order(created_at: :desc) }
  scope :my_tasks, -> { where(employee_id: Current.user.id) }
  scope :with_priority, ->(priority) { where("priority = ?", priority) }
  scope :condition, ->(prop, value) { where("#{prop} = ?", value) }
  scope :with_date, ->(value) { where("date = ?", value) }
  scope :with_repeatation, -> { where.not(repeat: "Onetime") }
  def self.task_specific_statuses(task)
    if task.done
      Task.statuses
    else
      Task.statuses.reject { |k, _v| k == "completed" }
    end
  end
end
