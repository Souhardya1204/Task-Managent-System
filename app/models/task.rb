class Task < ApplicationRecord
  belongs_to :user
  validates :employee_id, presence: true
  has_one_attached :document
end
