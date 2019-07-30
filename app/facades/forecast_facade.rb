class ForecastFacade
  def initialize(location_query)
    @location_query = {address: location_query}
  end

  def forecast
    Forecast.new(forecast_data, location)
  end

  private

  attr_reader :location_query

  def google_service
    @_google_service ||= GoogleService.new(@location_query)
  end

  def lat_long
    google_service.fetch_latlong
  end

  def location
    google_service.fetch_location
  end

  def forecast_data
    @_forecast_data ||= DarkSkyService.new(lat_long).fetch_forecast
  end
end
