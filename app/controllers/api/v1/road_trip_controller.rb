class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: api_key_params[:api_key])
    if user
      facade = RoadTripFacade.new(road_trip_params)
      render json: RoadTripForecastSerializer.new(facade.forecast), status: 200
    else
      render json: {error:  'No api key.'}, status: 401
    end
  end

  private

  def road_trip_params
    params.permit(:origin, :destination)
  end

  def api_key_params
    params.permit(:api_key)
  end
end
