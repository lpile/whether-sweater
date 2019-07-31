class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      facade = RoadTripFacade.new(road_trip_params)
      render json: RoadTripForecastSerializer.new(facade.forecast)
    else
      render json: {error:  'No api key.'}, status: 401
    end
  end

  private

  def road_trip_params
    params.permit(:origin, :destination)
  end
end
