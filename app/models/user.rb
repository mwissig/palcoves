class User < ApplicationRecord
  has_many :usernames, dependent: :destroy
  before_save { self.email = email.downcase }
  has_secure_password
  validates :password, presence: true, length: { maximum: 32, minimum: 6 }
  validates :email, presence: true, length: { maximum: 100 }
  validates :password, confirmation: { case_sensitive: true }
  before_commit :set_confirmation_token, only: %i[new create]
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

  def create
   @user = User.new(user_params)
   if @user.save
      @user.set_confirmation_token
      @user.save(validate: false)
                  UserMailer.registration_confirmation(@user).deliver_now
     flash[:success] = "Please confirm your email address to continue"
  else
     flash[:error] = "Invalid, please try again"
     render :new
  end
end

  # private

def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  def set_confirmation_token
     if self.confirm_token.blank?
         self.confirm_token = SecureRandom.urlsafe_base64.to_s
   end
 end



end
