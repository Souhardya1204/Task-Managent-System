class Subtask < ApplicationRecord
  belongs_to :task
  validates :title, :description, presence:true
end
