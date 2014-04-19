class User < ActiveRecord::Base
  has_many :todos
  has_secure_password
  validates :email, presence: true

  def self.authenticate email, password
    user = User.find_by_email email

    if user
      user.authenticate(password)
    else
      nil
    end
  end
end
