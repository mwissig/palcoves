class Username < ApplicationRecord
  belongs_to :user
    has_many :posts
  has_one_attached :avatar
  before_save { self.name = name.downcase }
before_save { self.slug = name }
# before_save { self.user_id = @current_user.id }
  validates :name, presence: true, length: { maximum: 100, minimum: 3 }, format: {  with: /\A[a-zA-Z0-9]+\Z/, message: "username contains invalid characters" }
  extend FriendlyId
  friendly_id :name, use: :slugged
end
