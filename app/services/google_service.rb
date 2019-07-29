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

  private

    attr_reader :filter, :key

    def conn
      Faraday.new('https://maps.googleapis.com')
    end

    def get_json(url)
      response = conn.get(url, key.merge(filter))
      JSON.parse(response.body, symbolize_names: true)
    end
end
