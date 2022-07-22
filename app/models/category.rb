# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true
  default_scope { order(created_at: :desc) }
  def self.per_page
    5
  end
end
