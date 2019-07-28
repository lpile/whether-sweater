class ForecastFacade
  def initialize(location_query)
    @location = {address: location_query}
  end

  def get_forecast
    currently = current_forecast(dark_sky_service[:currently])
    hourly = hourly_forecasts(dark_sky_service[:hourly][:data].first(8))
    daily = daily_forecasts(dark_sky_service[:daily][:data].first(5))
    forecast_response(currently, hourly, daily)
  end

  private

  attr_reader :location

  def google_service
    @_google_service ||= GoogleService.new(@location)
  end

  def dark_sky_service
    @_dark_sky_service ||= DarkSkyService.new(google_service.get_latlong).get_weather
  end

  def forecast_response(currently, hourly, daily)
    {
      data:
      {
        location: google_service.get_location,
        currently: JSON.parse(currently),
        hourly: JSON.parse(hourly),
        daily: JSON.parse(daily)
      }
    }
  end

  def current_forecast(currently_data)
    currently_data.to_json(only: [:time, :summary, :icon, :precipProbability, :precipType, :temperature, :apparentTemperature, :humidity, :uvIndex, :visibility])
  end

  def hourly_forecasts(hourly_data)
    hourly_data.map.to_json(only: [:time, :summary, :icon, :temperature])
  end

  def daily_forecasts(daily_data)
    daily_data.map.to_json(only: [:time, :icon, :precipProbability, :precipType, :temperatureHigh, :temperatureLow])
  end
end
