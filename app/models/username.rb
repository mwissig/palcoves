class Username < ApplicationRecord
  belongs_to :user
    has_many :posts
  has_one_attached :avatar
  before_save { self.name = name.downcase }
before_save { self.slug = name }
# before_save { self.user_id = @current_user.id }
  validates :name, presence: true, length: { maximum: 100, minimum: 3 }, format: {  with: /\A[a-zA-Z0-9]+\Z/, message: "username contains invalid characters" }
acts_as_url :name, url_attribute: :slug
def to_param
  slug
end
def self.find_by_param(input)
  find_by_name(input)
end
end
