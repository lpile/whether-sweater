class FlickrService
  def initialize
    @key = {
      api_key: ENV['FLICKR_API_KEY'],
      nojsoncallback: 1,
      format: 'json'}
  end

  def find_image_id(image_query)
    params = {
      method: 'flickr.photos.search',
      text: image_query,
      sort: 'interestingness-desc',
      safe_search: 1,
      content_type: 1,
      accuracy: 11,
      has_geo: 1,
      geo_context: 2
    }

    get_json('/services/rest', params)[:photos][:photo].first[:id]
  end

  def get_image_info(image_id)
    params = {
      method: 'flickr.photos.getInfo',
      photo_id: image_id
    }

    get_json('/services/rest', params)[:photo][:urls][:url].first[:_content]
  end

  private

    attr_reader :key

    def conn
      Faraday.new('https://api.flickr.com')
    end

    def get_json(url, params)
      response = conn.get(url, key.merge(params))
      JSON.parse(response.body, symbolize_names: true)
    end
end
