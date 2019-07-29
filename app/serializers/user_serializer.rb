class UserSerializer
  attr_reader :user

  def initialize(user = nil)
    @user = user
  end

  def api_key_response
    { api_key: user.api_key }
  end

  def error_response
    { error: 'Failed to register.' }
  end
end
