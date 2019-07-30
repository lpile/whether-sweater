class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      render json: { api_key: user.api_key }, status: 200
    else
      render json: {error: 'Failed to login.'}, status: 406
    end
  end
end
