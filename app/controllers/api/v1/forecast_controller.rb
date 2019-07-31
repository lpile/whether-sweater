class Api::V1::ForecastController < ApplicationController
  def index
    facade = ForecastFacade.new(location_params[:location])
    render json: ForecastSerializer.new(facade.forecast)
  end

  private

  def location_params
    params.permit(:location)
  end
end
