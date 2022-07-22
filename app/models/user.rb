# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :notifications, dependent: :destroy
  before_save { self.email = email.downcase }
  before_save { self.name = name.titleize }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX, message: "must be a valid email address" },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  enum role: { Admin: "admin", Hrd: "hrd", Employee: "employee" }
  def admin?
    return true if role == "Admin"

    false
  end

  def hr?
    return true if role == "Hrd"

    false
  end

  def self.per_page
    5
  end

  # rubocop:disable Metrics/AbcSize
  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name.capitalize
      user.email = auth.info.email
      user.password = SecureRandom.hex
    end
  end
  # rubocop:enable Metrics/AbcSize
end
