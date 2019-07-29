class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user).api_key_response, status: 201
    else
      render json: UserSerializer.new.error_response, status: 406
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
