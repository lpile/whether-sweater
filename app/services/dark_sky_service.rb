class DarkSkyService
  def initialize(filter = {})
    @filter = filter
  end

  def get_weather
    get_json("/forecast/#{ENV['DARKSKY_SECRET_KEY']}/#{latitude},#{longitude}")
  end

  private

    attr_reader :filter

    def conn
      Faraday.new('https://api.darksky.net')
    end

    def get_json(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end

    def latitude
      @filter[:lat]
    end

    def longitude
      @filter[:lng]
    end
end
