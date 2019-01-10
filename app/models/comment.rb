class Comment < ApplicationRecord
  belongs_to :username
  belongs_to :post
  # has_one_attached :image
  validates :body, presence: true, length: { minimum: 12 }
end
