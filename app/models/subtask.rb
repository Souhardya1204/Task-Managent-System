class Subtask < ApplicationRecord
  belongs_to :task
  validates :title, :description, presence: true
  has_many_attached :documents
end
