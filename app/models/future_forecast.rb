class FutureForecast
  attr_reader :id, :road_trip, :currently_data, :offset

  def initialize(forecast_data, road_trip)
    @id = 0
    @road_trip = road_trip
    @currently_data = forecast_data[:currently]
    @offset = forecast_data[:offset]
  end

  def currently
    {
      location: road_trip[:end_address],
      estimated_travel_time: road_trip[:duration][:text],
      arrival_time: Time.at(currently_data[:time]).in_time_zone(offset).strftime('%I:%M%p %m/%d/%y'),
      summary: currently_data[:summary],
      icon: currently_data[:icon],
      temperature: currently_data[:temperature].round,
      feels_like: currently_data[:apparentTemperature].round,
      humidity: (currently_data[:humidity] * 100).to_i,
      visibility: currently_data[:visibility].round(2),
      uvIndex: currently_data[:uvIndex]
    }
  end
end
