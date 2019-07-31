class DarkSkyService
  def initialize(filter = {})
    @latitude = filter[:lat]
    @longitude = filter[:lng]
  end

  def fetch_forecast
    get_json("/forecast/#{ENV['DARKSKY_SECRET_KEY']}/#{latitude},#{longitude}")
  end

  def fetch_future_forecast(time)
    get_json("/forecast/#{ENV['DARKSKY_SECRET_KEY']}/#{latitude},#{longitude},#{time}")
  end

  private

  attr_reader :latitude, :longitude

  def conn
    Faraday.new('https://api.darksky.net')
  end

  def get_json(url)
    response = conn.get(url, {exclude: 'minutely,alerts,flags'})
    JSON.parse(response.body, symbolize_names: true)
  end
end
