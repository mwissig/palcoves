class User < ApplicationRecord
  # has_many :usernames
  before_save { self.email = email.downcase }
  has_secure_password
  validates :password, presence: true, length: { maximum: 32, minimum: 6 }
  validates :email, presence: true, length: { maximum: 100 }

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCRYPT::Engine.min_cost
    BCrypt::Password.create(string, cost: cost)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
end
