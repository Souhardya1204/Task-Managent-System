# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  validates :employee_id, :name, :priority, presence: true
  has_many_attached :documents
  has_many :subtasks, dependent: :destroy
  enum status: { Pending: "Pending", "In Progress": "In Progress", Completed: "Completed" }
  enum priority: { High: 1, Medium: 2, Low: 3 }
  enum repeat: { Onetime: "Onetime", Daily: "Daily", Weekly: "Weekly", Monthly: "Monthly", Quarterly: "Quarterly",
                 Halfyearly: "Halfyearly", Yearly: "Yearly" }
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
      Task.statuses.reject { |k, _v| k == "Completed" }
    end
  end

  def self.per_page
    5
  end
end
