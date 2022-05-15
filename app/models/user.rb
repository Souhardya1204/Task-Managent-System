class User < ApplicationRecord
  has_many :tasks
  before_save { self.email = email.downcase }
  after_create :assign_default_role
  rolify
  validates :name, presence:true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX, message: "must be a valid email address" }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
      
  def assign_default_role
    self.add_role(:employee) if self.roles.blank?
  end

end
