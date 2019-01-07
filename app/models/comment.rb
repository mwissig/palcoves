class Comment < ApplicationRecord
  belongs_to :username
  # has_one_attached :image
  validates :body, presence: true, length: { minimum: 20 }
end
