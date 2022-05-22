class User < ApplicationRecord
  has_many :tasks, :dependent => :destroy
  before_save { self.email = email.downcase }
  validates :name, presence:true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX, message: "must be a valid email address" }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def is_admin?
    if self.role == "admin"
      return true
    end
    return false
  end
end
