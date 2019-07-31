class RoadTripFacade
  def initialize(params)
    @params = params
  end

  def forecast
    forecast_data = road_trip_forecast(future_time)
    FutureForecast.new(forecast_data, road_trip)
  end

  private

  attr_reader :params

  def road_trip
    GoogleService.new.fetch_duration(params)
  end

  def dark_sky_service
    @_dark_sky_service ||= DarkSkyService.new(road_trip[:end_location])
  end

  def road_trip_forecast(future_time)
    dark_sky_service.fetch_future_forecast(future_time)
  end

  def future_time
    Time.now.to_i + road_trip[:duration][:value]
  end
end
