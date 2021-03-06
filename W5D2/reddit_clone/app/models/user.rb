class User < ApplicationRecord
  validates :username, :password_digest, presence: true, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  has_many :subs,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :Sub

  has_many :posts,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Post

  has_many :comments,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Comment


  attr_reader :password

  after_initialize :ensure_token

  def ensure_token
    self.session_token ||= User.generate_token
  end

  def self.generate_token
    SecureRandom.urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def valid_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user && user.valid_password?(password)
      user
    else
      nil
    end
  end

  def reset_session_token!
    self.session_token = User.generate_token
    self.save
    self.session_token
  end


end
