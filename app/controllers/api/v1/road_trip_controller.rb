class Api::V1::RoadTripController < ApplicationController
  def create
    if params[:api_key]
      render json: RoadTripFacade.new(params).find_future_forecast
    else
      render json: {error:  'No api key.'}, status: 401
    end
  end
end
