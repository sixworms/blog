require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  #attr_accessible :email
  validates :email, :presence => true

  before_create :generate_confirmation_token

  def password
    @password ||= Password.new(self.encrypted_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.encrypted_password = @password
  end

  def confirm!
    self.confirmation_token = nil
    self.confirmed_at = Time.now.utc
    self.save!
  end

  private

  def generate_confirmation_token
    loop do
      token = SecureRandom.urlsafe_base64
      unless User.where(:confirmation_token => token).any?
        self.confirmation_token = token
        self.confirmation_sent_at = Time.now.utc
        break
      end
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
