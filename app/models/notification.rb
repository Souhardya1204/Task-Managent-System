# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user
  default_scope { order(created_at: :desc) }
  scope :unread, -> { where(seen: false) }
  def self.per_page
    1
  end
end
