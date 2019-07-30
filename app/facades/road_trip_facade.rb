class RoadTripFacade
  def initialize(params)
    @params = params
  end

  def find_future_forecast
    hour_forecast = fetch_hourly_forecast.min_by do |forecast|
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
    @_dark_sky_service ||= DarkSkyService.new(google_service.fetch_latlong)
  end

  def fetch_hourly_forecast
    @_fetch_hourly_forecast ||= dark_sky_service.fetch_forecast[:hourly][:data]
  end

  def duration_data
    @_duration_data ||= GoogleService.new.fetch_duration(params)
  end

  def future_time
    Time.now.to_i + duration_data[:value]
  end

  def road_trip_response(forecast)
    {
      data:
      {
        estimated_travel_time: duration_data[:text],
        hourly: JSON.parse(forecast),
      }
    }
  end

  def hourly_forecasts(hourly_data)
    hourly_data.to_json(only: [:time, :summary, :icon, :temperature])
  end
end
