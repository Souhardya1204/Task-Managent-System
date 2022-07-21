# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true
  def self.per_page
    1
  end
end
