require 'bb-ruby'
class Post < ApplicationRecord
  belongs_to :username
  has_one_attached :image
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { maximum: 256, minimum: 3 }
  validates :body, presence: true, length: { minimum: 12 }
end
