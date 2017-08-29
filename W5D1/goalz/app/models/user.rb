class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  def self.find_by_credentials(username)
    user = User.find_by(username: username)
    user ? user : nil
  end

  def ensure_session_token
    @session_token ||= User.generate_token
  end

  def reset_session_token!
    @session_token = User.generate_token
  end

  def self.generate_token
    SecureRandom.base64
  end

  

end
