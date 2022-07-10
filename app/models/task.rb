class Task < ApplicationRecord
  belongs_to :user
  validates :employee_id, :name, :priority, presence: true
  has_many_attached :documents
  has_many :subtasks, dependent: :destroy
  scope :my_tasks, -> { where(employee_id: Current.user.id) }
  scope :with_priority, ->(priority) { where("priority = ?", priority) }
end
