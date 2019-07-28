class Api::V1::ForecastController < ApplicationController
  def index
    render json: ForecastFacade.new(params[:location]).get_forecast
  end
end
