class Forecast
  attr_reader :id, :location, :currently_data, :hourly_data, :daily_data, :offset

  def initialize(forecast_data, location)
    @id = 0
    @location = location
    @currently_data = forecast_data[:currently]
    @hourly_data = forecast_data[:hourly][:data].first(8)
    @daily_data = forecast_data[:daily][:data].first(6)
    @offset = forecast_data[:offset]
  end

  def currently
    {
      location: location,
      time: Time.at(currently_data[:time]).in_time_zone(offset).strftime('%I:%M%p %m/%d/%y'),
      summary: currently_data[:summary],
      icon: currently_data[:icon],
      temperature: currently_data[:temperature].round,
      dailyHigh: daily_data.first[:temperatureHigh].round,
      dailyLow: daily_data.first[:temperatureLow].round,
      feels_like: currently_data[:apparentTemperature].round,
      humidity: (currently_data[:humidity] * 100).to_i,
      visibility: currently_data[:visibility].round(2),
      uvIndex: currently_data[:uvIndex]
    }
  end

  def hourly
    hourly_data.map do |index|
      {
        time: Time.at(index[:time]).in_time_zone(offset).strftime('%I:%M%p'),
        icon: index[:icon],
        temperature: index[:temperature].round
      }
    end
  end

  def daily
    daily_data[1..5].map do |index|
      {
        time: Time.at(index[:time]).in_time_zone(offset).strftime('%A'),
        icon: index[:icon],
        precipProbability: (index[:precipProbability] * 100).to_i,
        precipType: index[:precipType],
        temperatureHigh: index[:temperatureHigh].round,
        temperatureLow: index[:temperatureLow].round
      }
    end
  end
end
