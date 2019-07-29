class UserSerializer
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def api_key_response
    { api_key: user.api_key }
  end
end
