class User < ApplicationRecord
  before_validation :create_api_key

  validates :email, uniqueness: true, presence: true
  validates_presence_of :api_key, :password

  has_secure_password

  private

  def create_api_key
    self.api_key = SecureRandom.hex(10)
  end
end
