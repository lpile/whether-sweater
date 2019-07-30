class RoadTripFacade
  def initialize(params)
    @params = params
  end

  def find_future_forecast
    hour_forecast = get_hourly_forecast.min_by do |forecast|
      (forecast[:time] - future_time).abs
    end
    forecast = hourly_forecasts(hour_forecast)
    road_trip_response(forecast)
  end

  private

  attr_reader :params

  def google_service
    @_google_service ||= GoogleService.new(address: params[:destination])
  end

  def dark_sky_service
    @_dark_sky_service ||= DarkSkyService.new(google_service.get_latlong)
  end

  def get_hourly_forecast
    @_get_hourly_forecast ||= dark_sky_service.get_weather[:hourly][:data]
  end

  def direction_data
    @_direction_data ||= GoogleService.new.get_direction(params)[:legs].first
  end

  def future_time
    Time.now.to_i + direction_data[:duration][:value]
  end

  def road_trip_response(forecast)
    {
      data:
      {
        estimated_travel_time: direction_data[:duration][:text],
        hourly: JSON.parse(forecast),
      }
    }
  end

  def hourly_forecasts(hourly_data)
    hourly_data.to_json(only: [:time, :summary, :icon, :temperature])
  end
end
