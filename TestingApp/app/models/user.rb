class User < ApplicationRecord
  validates :username, :password_digest, presence: true, uniqueness: true
  validates :password, length: { minimum: 5, allow_nil: true}
  after_initialize :ensure_session_token!

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token!
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end



end
