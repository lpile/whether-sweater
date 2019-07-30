class GoogleService
  def initialize(filter = {})
    @filter = filter
    @key = {key: ENV['GOOGLE_API_KEY']}
  end

  def get_latlong
    get_json('/maps/api/geocode/json')[:results].first[:geometry][:location]
  end

  def get_location
    get_json('/maps/api/geocode/json')[:results].first[:formatted_address]
  end

  def get_direction(filter)
    @filter = {
      origin: filter[:origin],
      destination: filter[:destination]
    }

    get_json('/maps/api/directions/json')[:routes].first
  end

  private

    attr_reader :key
    attr_accessor :filter

    def conn
      Faraday.new('https://maps.googleapis.com')
    end

    def get_json(url)
      response = conn.get(url, key.merge(filter))
      JSON.parse(response.body, symbolize_names: true)
    end
end
