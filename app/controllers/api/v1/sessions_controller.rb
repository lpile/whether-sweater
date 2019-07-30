class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      render json: UserSerializer.new(user).api_key_response, status: 200
    else
      render json: UserSerializer.new.login_error_response, status: 406
    end
  end
end
