# frozen_string_literal: true

class Subtask < ApplicationRecord
  belongs_to :task
  validates :title, :description, presence: true
  has_many_attached :documents
  default_scope { order(created_at: :desc) }
end
