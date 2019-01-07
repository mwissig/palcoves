class Username < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar
  before_save { self.username = username.downcase }
  validates :username, presence: true, length: { maximum: 100, minimum: 3 }, format: {  with: /\A[a-zA-Z0-9]+\Z/, message: "username contains invalid characters" }
end
