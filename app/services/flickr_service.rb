class FlickrService
  def initialize(image_query)
    @params = {
      api_key: ENV['FLICKR_API_KEY'],
      method: 'flickr.photos.search',
      sort: 'interestingness-desc',
      safe_search: 1,
      content_type: 1,
      accuracy: 11,
      has_geo: 1,
      format: 'json',
      nojsoncallback: 1,
      tags: "#{image_query}, skyline",
      tag_mode: 'all',
      in_gallery: 'true',
      per_page: 10
    }
  end

  def fetch_images
    get_json('/services/rest')
  end

  private

  attr_reader :params

  def conn
    Faraday.new('https://api.flickr.com')
  end

  def get_json(url)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end
end
